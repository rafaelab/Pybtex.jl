# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.show(io::IO, bib::BibLibrary) -> Nothing

Pretty-print a `BibLibrary` to an `IO` stream.

# Input
- `io::IO` : output stream (e.g. `stdout`)
- `bib::BibLibrary` : library to describe

# Output
- `Nothing` : prints a short summary to `io`

# Example
```jl
show(stdout, library)
```
"""
function Base.show(io::IO, bib::BibLibrary)
    n = length(bib.entries)
    s = @sprintf("BibLibrary containing %i entries.\n", n)
    print(io, s)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.show(io::IO, person::PersonName) -> Nothing

Format and print a `PersonName` to an `IO` stream.

# Input
- `io::IO` : output stream
- `person::PersonName` : person structure with `firstName`, `middleName`, `lastName`, and optional `suffix`

# Output
- `Nothing` : prints the formatted name to `io`

# Example
```jl
show(stdout, author)
```
"""
function Base.show(io::IO, person::PersonName)
	s = ""
	s *= @sprintf("%s", person.firstName)
	if ! isempty(person.middleName)
		s *= @sprintf(" %s", person.middleName)
	end
	s *= @sprintf(" %s", person.lastName)
	if ! isempty(person.suffix)
		s *= @sprintf(" %s", person.suffix)
	end
	print(io, s)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.show(io::IO, entry::BibEntry{Article}) -> Nothing

Pretty-print a `BibEntry{Article}` to an `IO` stream.

# Input
- `io::IO` : output stream
- `entry::BibEntry{Article}` : article entry wrapper

# Output
- `Nothing` : prints formatted article metadata to `io`

# Example
```jl
show(stdout, article_entry)
```
"""
function Base.show(io::IO, entry::BibEntry{Article})
	s = @sprintf("bibkey: %s [%s]\n", entry.key, getType(entry))

	s *= @sprintf("  title: %s\n", getTitle(entry))
	s *= @sprintf("  authors:\n")
	for author ∈ getAuthors(entry)
		s *= @sprintf("    %s\n", author)
	end

	s *= @sprintf("  journal: %s\n", getJournal(entry))
	s *= @sprintf("  volume: %s\n", getVolume(entry))
	if hasField(entry, "number")
		s *= @sprintf("  number: %s\n", getNumber(entry))
	end
	if hasField(entry, "pages")
		s *= @sprintf("  pages: %s\n", getPages(entry))
	end
	if hasField(entry, "year")
		s *= @sprintf("  year: %s\n", getYear(entry))
	end

	if hasField(entry, "doi")
		s *= @sprintf("  doi: %s\n", getDOI(entry))
	end
	if hasField(entry, "url")
		s *= @sprintf("  url: %s\n", getURL(entry))
	end

	print(io, s)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.show(io::IO, entry::BibEntry{Book}) -> Nothing

Pretty-print a `BibEntry{Book}` to an `IO` stream.

# Input
- `io::IO` : output stream
- `entry::BibEntry{Book}` : book entry wrapper

# Output
- `Nothing` : prints formatted book metadata to `io`

# Example
```jl
show(stdout, book_entry)
```
"""
function Base.show(io::IO, entry::BibEntry{Book}) 
    s = @sprintf("bibkey: %s [%s]\n", entry.key, getType(entry))

	s *= @sprintf("  title: %s\n", getTitle(entry))

	if numberOfAuthors(entry) > 0
		s *= @sprintf("  authors:\n")
		for author ∈ getAuthors(entry)
			s *= @sprintf("    %s\n", author)
		end
	end
	if numberOfEditors(entry) > 0
		s *= @sprintf("  editors:\n")
		for editor ∈ getEditors(entry)
			s *= @sprintf("    %s\n", editor)
		end
	end

	if hasField(entry, "booktitle")
		s *= @sprintf("  booktitle: %s\n", getBookTitle(entry))
	end
	if hasField(entry, "year")
		s *= @sprintf("  year: %s\n", getYear(entry))
	end
	if hasField(entry, "edition")
		s *= @sprintf("  edition: %s\n", getEdition(entry))
	end

	if hasField(entry, "location")
		s *= @sprintf("  location: %s\n", getLocation(entry))
	end
	if hasField(entry, "publisher")
		s *= @sprintf("  publisher: %s\n", getPublisher(entry))
	end

	if hasField(entry, "doi")
		s *= @sprintf("  doi: %s\n", getDOI(entry))
	end
	if hasField(entry, "url")
		s *= @sprintf("  url: %s\n", getURL(entry))
	end
	if hasField(entry, "isbn")
		s *= @sprintf("  isbn: %s\n", getISBN(entry))
	end

	print(io, s)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
	Base.show(io::IO, entry::BibEntry{T}) where {T<:BibType} -> Nothing

Pretty-print a generic `BibEntry{T}` to an `IO` stream.

# Input
- `io::IO` : output stream
- `entry::BibEntry{T}` : generic bib entry (type-specific fields will be shown when available)

# Output
- `Nothing` : prints formatted metadata to `io`

# Example
```jl
show(stdout, some_entry)
```
"""
function Base.show(io::IO, entry::BibEntry{T}) where {T <: BibType}
    s = @sprintf("bibkey: %s [%s]\n", entry.key, getType(entry))

	s *= @sprintf("  title: %s\n", getTitle(entry))

	if numberOfAuthors(entry) > 0
		s *= @sprintf("  authors:\n")
		for author ∈ getAuthors(entry)
			s *= @sprintf("    %s\n", author)
		end
	end
	if numberOfEditors(entry) > 0
		s *= @sprintf("  editors:\n")
		for editor ∈ getEditors(entry)
			s *= @sprintf("    %s\n", editor)
		end
	end
	
	s *= @sprintf("  journal: %s\n", getJournal(entry))
	if hasField(entry, "booktitle")
		s *= @sprintf("  booktitle: %s\n", getBookTitle(entry))
	end
	s *= @sprintf("  volume: %s\n", getVolume(entry))
	if hasField(entry, "number")
		s *= @sprintf("  number: %s\n", getNumber(entry))
	end
	if hasField(entry, "pages")
		s *= @sprintf("  pages: %s\n", getPages(entry))
	end
	if hasField(entry, "year")
		s *= @sprintf("  year: %s\n", getYear(entry))
	end
	if hasField(entry, "edition")
		s *= @sprintf("  edition: %s\n", getEdition(entry))
	end

	if hasField(entry, "location")
		s *= @sprintf("  location: %s\n", getLocation(entry))
	end
	if hasField(entry, "publisher")
		s *= @sprintf("  publisher: %s\n", getPublisher(entry))
	end

	if hasField(entry, "doi")
		s *= @sprintf("  doi: %s\n", getDOI(entry))
	end
	if hasField(entry, "url")
		s *= @sprintf("  url: %s\n", getURL(entry))
	end
	if hasField(entry, "isbn")
		s *= @sprintf("  isbn: %s\n", getISBN(entry))
	end

	print(io, s)
end



# ----------------------------------------------------------------------------------------------- #
#