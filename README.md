# kraken-voulgaris-aeneid

<https://ryanfb.github.io/kraken-voulgaris-aeneid/groundtruth/>

This is a project for generating an edition-specific OCR training file for [Kraken](http://kraken.re/) for Evgenios Voulgaris' Greek translation of the Aeneid.

## Data

The following Google Books volumes were used as source data:

* <http://books.google.com/books?id=jGJdAAAAcAAJ>
* <http://books.google.com/books?id=lmJdAAAAcAAJ>
* <http://books.google.com/books?id=d-Z1DfR7hFUC>

Copies of these are available as renamed PDFs in the `pdfs` directory.

## Training

Run `make`, or override defaults with e.g.

    USE_DOCKER=false CUDA_DEVICE=cuda:0 make
