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
	getArxiv,
	getDoi,
	getURL,
	getIsbn,
	getAdsUrl,
	getEId,
	getAbstract,
	getKeywords,
	getFileName,
	getBibtex,
	bibEntryToDict,
	getType,
	numberOfAuthors,
	numberOfEditors,
	getAllFields


using LaTeXStrings
using OrderedCollections
using Printf
using PythonCall


pybtex = pyimport("pybtex")

include("common.jl")
include("journals.jl")
include("person.jl")
include("types.jl")
include("entry.jl")
include("database.jl")
include("io.jl")



end # module Pybtex
