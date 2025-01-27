# ----------------------------------------------------------------------------------------------- #
#
function Base.show(io::IO, bib::BibLibrary)
	n = length(bib.entries)
	s = @sprintf("BibLibrary containing %i entries.\n", n)
	print(io, s)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function provides a simple way to print a person's name to the console.
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
This function provides a simple way to print a BibEntry to the console.
"""
function Base.show(io::IO, entry::BibEntry{Article})
	s = @sprintf("bibkey: %s [%s]\n", entry.key, getType(entry))

	s *= @sprintf("  title: %s\n", getTitle(entry))
	s *= @sprintf("  authors:\n")
	for author in getAuthors(entry)
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

function Base.show(io::IO, entry::BibEntry{Book}) 
	s = @sprintf("bibkey: %s [%s]\n", entry.key, getType(entry))

	s *= @sprintf("  title: %s\n", getTitle(entry))

	if numberOfAuthors(entry) > 0
		s *= @sprintf("  authors:\n")
		for author in getAuthors(entry)
			s *= @sprintf("    %s\n", author)
		end
	end
	if numberOfEditors(entry) > 0
		s *= @sprintf("  editors:\n")
		for editor in getEditors(entry)
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

function Base.show(io::IO, entry::BibEntry{T}) where {T <: BibType}
	s = @sprintf("bibkey: %s [%s]\n", entry.key, getType(entry))

	s *= @sprintf("  title: %s\n", getTitle(entry))

	if numberOfAuthors(entry) > 0
		s *= @sprintf("  authors:\n")
		for author in getAuthors(entry)
			s *= @sprintf("    %s\n", author)
		end
	end
	if numberOfEditors(entry) > 0
		s *= @sprintf("  editors:\n")
		for editor in getEditors(entry)
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