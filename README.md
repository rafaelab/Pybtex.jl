# Pybtex.jl


This is a Julia wrapper for [pybtex](https://pybtex.org/).

It contains very basic features in a convenient form.
Note that the list of journal abbreviations I added here are mostly for the astro/particle community, since this package is for personal usage.

The design is meant to be used for various purposes, including exporting the BibTeX library (or part of it) to a convenient format.
Another interesting application is to create a list of publications in LaTeX to accompany a CV, for example.



## Examples

This example is available in the folder `examples`.
```
using Pybtex


library = readBibtexDataBase("sample.bib")

key = "sample"
entry = getEntry(library, key)
```
This will print information about the BibTeX entry `sample`.



## Known problems

Accents are not working very well.
