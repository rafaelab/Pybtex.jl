# ----------------------------------------------------------------------------------------------- #
#
@doc """
This module provides a simple interface to read and manipulate bibtex databases.
"""
struct BibLibrary
	db
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Returns the number of entries in the database.
"""
Base.length(db::BibLibrary) = length(db.entries.keys())


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Returns the entry with the given key.
"""
Base.getindex(db::BibLibrary, key) = db.entries[key]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Returns the keys of the entries in the database.
"""
Base.keys(db::BibLibrary) = String[stringPy2Jl(key) for key in db.entries.keys()]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Overload `Base`'s `getproperty` function to allow for accessing the entries of the database and useful aliases.
"""
function Base.getproperty(bib::BibLibrary, v::Symbol)
	if v == :entries
		return bib.db.entries
	else
		return getfield(bib, v)
	end
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Reads a bibtex database from a file and returns a `BibLibrary` object.
"""
function readBibtexDataBase(filename::String)
	style = pyimport("pybtex.plugin").find_plugin("pybtex.style.formatting", "plain")()
	parser = pyimport("pybtex.database.input.bibtex").Parser()
	d = parser.parse_file(filename)

	return BibLibrary(d)
end

# ----------------------------------------------------------------------------------------------- #
#
function writeBibtexDataBase(bib::BibLibrary, filename::String)
	bib.db.to_file(filename, bib_format = "bibtex")
end



# ----------------------------------------------------------------------------------------------- #
#