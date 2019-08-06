---
---

This is a project for generating an edition-specific OCR training file for [Kraken](http://kraken.re/) for Evgenios Voulgaris' Greek translation of the Aeneid.

## Instructions

 * Pick a non-corrected page (❌) from the list below (you might also check that there are no oopen [issues](https://github.com/ryanfb/kraken-voulgaris-aeneid/issues) for your page).
 * Feel free to open a provisional issue with the page you're working on (e.g. `voulgaris_1_page_00046`), if you want to avoid any potential duplication of effort. Simply close the issue if you abandon the work.
 * Read lines in image and correct the transcription to reflect *diplomatic* ground truth of what's represented in the image.
 * Pages are prefilled with OCR output from the [`kraken-gaza-iliad`](https://github.com/ryanfb/kraken-gaza-iliad) model. There will be plenty of errors, so if you feel it's faster to simply erase a line and type the transcription instead of correcting the prefilled output, feel free.
 * When done with a page, click "Download" and [make an issue](https://github.com/ryanfb/kraken-voulgaris-aeneid/issues) with the output. You can attach the downloaded HTML directly to the GitHub issue by zipping it first - on a Mac, you can right-click the file then click `Compress "filename.html"` to create a `.zip` file which GitHub will accept as an attachment.

## Notes

 * If a chunk is incorrectly chunked (multiple lines lumped together, or a single line cut in half), simply skip it and erase any prefilled text
 * Beginning of each line is usually capitalized
 * Pay close attention to punctuation, accents, capitalization, and spacing
 * This edition uses [stigma](https://en.wikipedia.org/wiki/Stigma_(letter)) for "στ": ϛ
 * There are also some "ου" ligatures: ȣ

## Pages

{% include_relative groundtruth-index.md %}
