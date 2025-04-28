push!(LOAD_PATH, "..")

using Pybtex



library = readBibtexDataBase("sample.bib")

key = "sample"
entry = getEntry(library, key)
