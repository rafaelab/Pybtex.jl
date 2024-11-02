# ----------------------------------------------------------------------------------------------- #
#
@doc """
This module provides the types used in the `BibLibrary` module.
These are the general BibTeX types useful for dispatching entries on them.
"""
abstract type BibType end

# ----------------------------------------------------------------------------------------------- #
#
struct Article <: BibType end
struct Book <: BibType end
struct Booklet <: BibType end
struct Conference <: BibType end
struct InBook <: BibType end
struct InCollection <: BibType end
struct InProceedings <: BibType end
struct Manual <: BibType end
struct MasterThesis <: BibType end
struct Misc <: BibType end
struct PhdThesis <: BibType end
struct Proceedings <: BibType end
struct TechReport <: BibType end
struct Thesis <: BibType end
struct Unpublished <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
typeDict = Dict(
	"article" => Article,
	"book" => Book,
	"booklet" => Booklet,
	"conference" => Conference,
	"inbook" => InBook,
	"incollection" => InCollection,
	"inproceedings" => InProceedings,
	"manual" => Manual,
	"mastersthesis" => MasterThesis,
	"misc" => Misc,
	"phdthesis" => PhdThesis,
	"proceedings" => Proceedings,
	"techreport" => TechReport,
	"thesis" => Thesis,
	"unpublished" => Unpublished
	)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Returns the name of the type of the entry as a string.
"""
getTypeName(::Type{Article}) = "article"
getTypeName(::Type{Book}) = "book"
getTypeName(::Type{Booklet}) = "booklet"
getTypeName(::Type{Conference}) = "conference"
getTypeName(::Type{InBook}) = "inbook"
getTypeName(::Type{InCollection}) = "incollection"
getTypeName(::Type{InProceedings}) = "inproceedings"
getTypeName(::Type{Manual}) = "manual"
getTypeName(::Type{MasterThesis}) = "mastersthesis"
getTypeName(::Type{Misc}) = "misc"
getTypeName(::Type{PhdThesis}) = "phdthesis"
getTypeName(::Type{Proceedings}) = "proceedings"
getTypeName(::Type{TechReport}) = "techreport"
getTypeName(::Type{Unpublished}) = "unpublished"


# ----------------------------------------------------------------------------------------------- #
#