DOCKER_IMAGE ?= ryanfb/kraken
CUDA_DEVICE ?= cpu
USE_DOCKER ?= true
DOCKER_SHM ?= 256M
PARALLEL_ARGS ?= -j 4

ifeq ($(USE_DOCKER),true)
	export DOCKER_PREFIX=docker run --shm-size=$(DOCKER_SHM) -it -v $(shell pwd):/data $(DOCKER_IMAGE)
else
	DOCKER_PREFIX=
endif

all: test-nfc

sequential_images images : | pdfs/voulgaris_1.pdf pdfs/voulgaris_2.pdf pdfs/voulgaris_3.pdf
	./scripts/extract-images.sh

groundtruth : | sequential_images
	./scripts/extract-train-sample.sh

groundtruth/groundtruth-index.md : | groundtruth
	./scripts/groundtruth-index.sh > groundtruth/groundtruth-index.md

lines : | sequential_images
	./scripts/extract-lines.sh

gaza_best_nfc.mlmodel:
	wget -c 'https://github.com/ryanfb/kraken-gaza-iliad/raw/master/gaza_best_nfc.mlmodel'

groundtruth-prefill : | groundtruth lines gaza_best_nfc.mlmodel
	./scripts/prefill-groundtruth.sh

groundtruth-checked groundtruth-unchecked : groundtruth/groundtruth-index.md groundtruth/*.html
	./scripts/split-groundtruth.sh

extract-nfd: groundtruth-checked/*.html | groundtruth-checked
	$(DOCKER_PREFIX) ketos extract --output extract-nfd --normalization NFD groundtruth-checked/*.html

voulgaris_best_nfd.mlmodel : extract-nfd
	time $(DOCKER_PREFIX) ketos train --device $(CUDA_DEVICE) --output voulgaris extract-nfd/*.png
	mv -v voulgaris_best.mlmodel voulgaris_best_nfd.mlmodel

test-nfd: voulgaris_best_nfd.mlmodel
	$(DOCKER_PREFIX) ketos test --device $(CUDA_DEVICE) -m voulgaris_best_nfd.mlmodel extract/*.png

extract-nfc: groundtruth-checked/*.html | groundtruth-checked
	$(DOCKER_PREFIX) ketos extract --output extract-nfc --normalization NFC groundtruth-checked/*.html

voulgaris_best_nfc.mlmodel : extract-nfc
	time $(DOCKER_PREFIX) ketos train --device $(CUDA_DEVICE) --output voulgaris extract-nfc/*.png
	mv -v voulgaris_best.mlmodel voulgaris_best_nfc.mlmodel

test-nfc: voulgaris_best_nfc.mlmodel
	$(DOCKER_PREFIX) ketos test --device $(CUDA_DEVICE) -m voulgaris_best_nfc.mlmodel extract/*.png

groundtruth-refill : voulgaris_best_nfc.mlmodel groundtruth-unchecked/*.html | groundtruth-unchecked
		./scripts/refill-groundtruth.sh

clean:
	rm -fv voulgaris_best_nfd.mlmodel voulgaris_best_nfc.mlmodel

.PHONY: groundtruth-prefill test-nfd test-nfc clean
