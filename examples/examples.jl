push!(LOAD_PATH, "..")

using Pybtex



library = readBibtexDataBase(joinpath(@__DIR__, "sample.bib"))

key = "sample"
entry = getEntry(library, key)
