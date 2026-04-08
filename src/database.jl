
# ----------------------------------------------------------------------------------------------- #
#
@doc """
	BibLibrary

This provides a simple interface to read and manipulate BibTeX databases.
Note that this is a full wrapper around the `pybtex.database.BibliographyData` class. 
The underlying entries are stored as they are in the Python library. 
The API provides helper functions to access common fields and properties, but the full entry objects are available for more advanced use cases.
"""
struct BibLibrary
	db
end

BibLibrary() = BibLibrary(pyimport("pybtex.database").BibliographyData())


BibLibrary(entries::Vector{T}) where {T <: BibEntry} = begin
	db = pydb.BibliographyData()
	for entry ∈ entries
		db.entries[entry.key] = entry
	end
	
	return BibLibrary(db)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.length(db::BibLibrary) -> Int64

Return the number of entries in the database.

# Input
- `db::BibLibrary` : a BibLibrary instance

# Output
- `Int` : number of entries stored

# Example
```jl
length(library)
```
"""
Base.length(db::BibLibrary) = length(db.entries.keys())


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.getindex(db::BibLibrary, key::AbstractString) -> Any

Return the stored entry for a given key.

# Input
- `db::BibLibrary` : the library to query
- `key::AbstractString` : bibtex key for the entry

# Output
- the stored entry (often a Python `Entry` or the wrapper expected by the API)

# Example
```jl
entry = library["smith2020"]
```
"""
Base.getindex(db::BibLibrary, key::AbstractString) = db.entries[key]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.keys(db::BibLibrary) -> Vector{String}

Return all keys present in the `BibLibrary` as a vector of `String`.

# Input
- `db::BibLibrary`

# Output
- `Vector{String}` : list of bibkeys

# Example
```jl
collect(keys(library))
```
"""
Base.keys(db::BibLibrary) = String[stringPy2Jl(key) for key ∈ db.entries.keys()]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.pop!(db::BibLibrary, key::AbstractString) -> Any

Remove and return the entry associated with `key`.

# Input
- `db::BibLibrary`
- `key::AbstractString` : key to remove

# Output
- the removed entry (or throws if not present)

# Example
```jl
removed = pop!(library, "smith2020")
```
"""
Base.pop!(db::BibLibrary, key::AbstractString) = db.entries.pop(key)


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	insert!(db::BibLibrary, entry::BibEntry) -> Nothing

Insert (or replace) a `BibEntry` into the library using its `key`.

# Input
- `db::BibLibrary`
- `entry::BibEntry` : a `BibEntry` wrapper object (the whole entry is stored)

# Output
- `Nothing` : operation mutates `db`

# Notes
- This implementation stores the whole `BibEntry` object under `entry.key`.

# Example
```jl
insert!(library, my_entry)
```
"""
Base.insert!(db::BibLibrary, entry::BibEntry) = begin
	db.entries[entry.key] = entry
	return nothing
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	haskeys(db::BibLibrary, keys::Vector{String}) -> Vector{Bool}

Check whether the given `key` exists in the library.

# Function
`Base.haskey(db::BibLibrary, key::AbstractString) -> Bool`

# Input
- `db::BibLibrary`
- `key::AbstractString`

# Output
- `Bool` : true if present

# Example
```jl
haskey(library, "smith2020")
```
"""
Base.haskey(db::BibLibrary, key::AbstractString) = key ∈ keys(db)

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	values(db::BibLibrary) -> Vector{Any}

Return a vector with all stored entries in the library.

# Input
- `db::BibLibrary`

# Output
- `Vector{Any}` : list of stored entries

# Example
```jl
vals = collect(values(library))
```
"""
Base.values(db::BibLibrary) = [db[key] for key ∈ keys(db)]


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.iterate(db::BibLibrary; state = 1) -> Union{Tuple{Any, Int}, Nothing}

Iterator for `BibLibrary` which yields stored entries.

# Input
- `db::BibLibrary`
- optional `state::Int` for iterator position

# Output
- `(entry, next_state)` or `nothing` when iteration finishes

# Example
```jl
for e in library
	println(e)
end
```
"""
function Base.iterate(db::BibLibrary; state = 1)
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
	Base.getproperty(bib::BibLibrary, v::Symbol) -> Any

Provide property access helpers for `BibLibrary`.

# Input
- `bib::BibLibrary`
- `v::Symbol` : property name; use `:entries` to access the underlying entries mapping

# Output
- returns `bib.db.entries` if `v == :entries`, otherwise falls back to `getfield`

# Example
```jl
bib.entries  # access underlying storage
```
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
	getEntry(bib::BibLibrary, key::AbstractString) -> BibEntry

Return a `BibEntry` wrapper for the stored entry with `key`.

# Input
- `bib::BibLibrary`
- `key::AbstractString`

# Output
- `BibEntry{T}` where `T` corresponds to the BibTeX type

# Example
```jl
entry = getEntry(library, "smith2020")
```
"""
function getEntry(bib::BibLibrary, key) 
	t = stringPy2Jl(bib.entries[key].type)
	T = typeDict[t]
	return BibEntry{T}(key, bib.entries[key])
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	readBibtexDataBase(filename::String) -> BibLibrary

Read a BibTeX file and return a `BibLibrary`.

# Input
- `filename::String` : path to a `.bib` file

# Output
- `BibLibrary` : parsed database

# Example
```jl
library = readBibtexDataBase("examples/sample.bib")
```
"""
function readBibtexDataBase(filename::String)
	style = pyimport("pybtex.plugin").find_plugin("pybtex.style.formatting", "plain")()
	parser = pyimport("pybtex.database.input.bibtex").Parser()
	d = parser.parse_file(filename)
	return BibLibrary(d)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	writeBibtexDataBase(bib::BibLibrary, filename::String) -> Nothing

Write a `BibLibrary` to a BibTeX file.

# Input
- `bib::BibLibrary` : library to write
- `filename::String` : output path

# Output
- `Nothing` : writes file to disk

# Notes
- Performs a post-processing replacement pass to clean common LaTeX sequences.

# Example
```jl
writeBibtexDataBase(library, "clean.bib")
```
"""
function writeBibtexDataBase(bib::BibLibrary, filename::String)
	libraryStr = pyconvert(String, bib.db.to_string(bib_format = "bibtex"))

	# now fix the file and remove things like `\textasciitilde{}`, etc
	items = Dict{String, String}(
		"\\textendash" => "–-",
		"\\textemdash" => "–--",
		"\\textasciitilde" => "~",
		"\\&" => "&",
		"\\_" => "_",
		"\\%" => "%",
		"\\#" => "#",
		"\\~ " => "\\~",
		"~ " => "~",
	)

	libraryStr2 = libraryStr
	for key ∈ keys(items)
		libraryStr2 = replace(libraryStr2, key => items[key])
	end
	write(filename, libraryStr2)

	return nothing
end



# ----------------------------------------------------------------------------------------------- #
#