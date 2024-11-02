module Pybtex

export 
	BibLibrary,
	BibEntry,
	readBibtexDataBase,
	getEntry,
	getAuthors,
	getEditors,
	getType,
	getTitle,
	getBookTitle,
	getYear,
	getJournal,
	getVolume,
	getNumber,
	getPages,
	getEdition,
	getLocation,
	getPublisher,
	getDOI,
	getURL,
	getAbstract,
	getKeywords,
	getBibTeX
	


using LaTeXStrings
using Printf
using PythonCall




pybtex = pyimport("pybtex")


include("common.jl")
include("database.jl")
include("journals.jl")
include("person.jl")
include("entry.jl")
include("io.jl")




end # module Pybtex
