# ----------------------------------------------------------------------------------------------- #
#
@doc """
This provides a simple interface to read and manipulate bibtex databases.
"""
struct BibLibrary
	db
end

BibLibrary() = BibLibrary(pyimport("pybtex.database").BibliographyData())


function BibLibrary(entries::Vector{T}) where {T <: BibEntry}
	db = pydb.BibliographyData()
	for entry in entries
		db.entries[entry.key] = entry
	end
	
	return BibLibrary(db)
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
Base.getindex(db::BibLibrary, key::AbstractString) = db.entries[key]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Returns the keys of the entries in the database.
"""
Base.keys(db::BibLibrary) = String[stringPy2Jl(key) for key in db.entries.keys()]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Remove an entry from the database based on its key.
"""
Base.pop!(db::BibLibrary, key::AbstractString) = db.entries.pop(key)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Insert an entry into the database.
"""
function Base.insert!(db::BibLibrary, entry::BibEntry) 
	db.entries[entry.key] = entry
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Check if a key exists in the database.
"""
Base.haskey(db::BibLibrary, key::AbstractString) = key ∈ keys(db)

# ----------------------------------------------------------------------------------------------- #
#
@doc """
Return a vector of all values in the database
"""
Base.values(db::BibLibrary) = [db[key] for key in keys(db)]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Iterate over the entries in the BibLibrary.
"""
function Base.iterate(db::BibLibrary, state = 1)
    keysIter = collect(keys(db))
    if state > length(keysIter)
        return nothing
    else
        current = keysIter[state]
        return (db[current], state + 1)
    end
end


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
This function returns a BibTeX entry from a BibTeX library.
"""
function getEntry(bib::BibLibrary, key) 
	t = stringPy2Jl(bib.entries[key].type)
	T = typeDict[t]
	return BibEntry{T}(key, bib.entries[key])
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