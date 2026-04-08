# ----------------------------------------------------------------------------------------------- #
#
@doc """
This module provides the types used in the `BibLibrary` module.
These are the general BibTeX types useful for dispatching entries on them.
"""
abstract type BibType end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Article

BibTeX type for journal articles.
"""
struct Article <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Book

BibTeX type for whole books.
"""
struct Book <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Booklet

BibTeX type for small printed works without a publisher.
"""
struct Booklet <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Conference

BibTeX type for conference-related publications.
"""
struct Conference <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	InBook

BibTeX type for a part of a book (e.g. chapter).
"""
struct InBook <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	InCollection

BibTeX type for a chapter or section in a collection.
"""
struct InCollection <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	InProceedings

BibTeX type for an article in conference proceedings.
"""
struct InProceedings <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Manual

BibTeX type for technical manuals.
"""
struct Manual <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	MasterThesis

BibTeX type for a master's thesis.
"""
struct MasterThesis <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Misc

BibTeX catch-all type for miscellaneous entries.
"""
struct Misc <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	PhDThesis

BibTeX type for a doctoral dissertation.
"""
struct PhDThesis <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Proceedings

BibTeX type for conference proceedings volumes.
"""
struct Proceedings <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	TechReport

BibTeX type for technical reports.
"""
struct TechReport <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Thesis

General BibTeX thesis type.
"""
struct Thesis <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Unpublished

BibTeX type for unpublished works.
"""
struct Unpublished <: BibType end


# ----------------------------------------------------------------------------------------------- #
#
const typeDict = Dict(
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
	"phdthesis" => PhDThesis,
	"proceedings" => Proceedings,
	"techreport" => TechReport,
	"thesis" => Thesis,
	"unpublished" => Unpublished
	)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	getTypeName(::Type{T}) where {T<:BibType} -> String

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
getTypeName(::Type{PhDThesis}) = "phdthesis"
getTypeName(::Type{Proceedings}) = "proceedings"
getTypeName(::Type{TechReport}) = "techreport"
getTypeName(::Type{Thesis}) = "thesis"
getTypeName(::Type{Unpublished}) = "unpublished"


# ----------------------------------------------------------------------------------------------- #
#