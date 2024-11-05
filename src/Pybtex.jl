module Pybtex

export 
	BibLibrary,
	BibEntry,
	readBibtexDataBase,
	writeBibtexDataBase,
	hasField,
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
	getSchool,
	getArXiv,
	getDOI,
	getURL,
	getISBN,
	getADSURL,
	getEId,
	getAbstract,
	getKeywords,
	getFileName,
	getBibTeX,
	getType,
	numberOfAuthors,
	numberOfEditors,
	getAllFields
	


using LaTeXStrings
using Printf
using PythonCall


pybtex = pyimport("pybtex")


include("common.jl")
include("database.jl")
include("journals.jl")
include("person.jl")
include("types.jl")
include("entry.jl")
include("io.jl")




end # module Pybtex
