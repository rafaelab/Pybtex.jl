# ----------------------------------------------------------------------------------------------- #
#
@doc """
This object represents a BibTeX entry. 
It is a wrapper around pybtex's `pybtex.database.Entry` object, connecting it with its corresponding key.
"""
struct BibEntry{T <: BibType}
	key::String
	info::Py
end


Base.eltype(::Type{BibEntry{T}}) where {T} = T

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function checks if a field is present in a BibTeX entry.
"""
hasField(entry::BibEntry, field::String) = haskey(pyconvert(Dict, entry.info.fields), lowercase(field))


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
This function returns the type of a BibTeX entry.
"""
function getType(::BibEntry{T}) where {T} 
	return getTypeName(T)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the authors of a BibTeX entry.
The authors are returned as a vector of `PersonName` objects.

If the authors field is not present, but editors are found, the editors are returned instead.
"""
function getAuthors(entry::BibEntry)
	if isempty(entry.info.persons["author"])
		if ! isempty(entry.info.persons["editor"])
			return getEditors(entry)
		else
			@warn "No authors field in entry \"$(entry.key)\"."
			return [PersonName("", "", "", "")]
		end
	end

	names = []
	for author in entry.info.persons["author"]
		name = pybtexToPersonName(author)
		push!(names, name)
	end

	return names
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the editors of a BibTeX entry.
The editors are returned as a vector of `PersonName` objects.
"""
function getEditors(entry::BibEntry)
	if ! haskey(entry.info.persons, "editor")
		return []
	end

	editors = entry.info.persons["editor"]
	if isempty(editors)
		return []
	end

	names = []
	for editor in editors
		name = pybtexToPersonName(editor)
		push!(names, name)
	end

	return names
end

# ----------------------------------------------------------------------------------------------- #
#
function getTitle(entry::BibEntry)
	if ! hasField(entry, "title")
		@warn "No title field in entry \"$(entry.key)\"."
		return ""
	end

	s = entry.info.fields["title"]
	s = stringPy2Jl(s)
	return removeCurlyBracesLimiters(s)
end

# ----------------------------------------------------------------------------------------------- #
#
function getBookTitle(entry::BibEntry)
	if ! hasField(entry, "title")
		@warn "No booktitle field in entry \"$(entry.key)\"."
		return ""
	end

	s = entry.info.fields["booktitle"]
	s = stringPy2Jl(s)
	return removeCurlyBracesLimiters(s)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the year of the publication.
"""
function getYear(entry::BibEntry)
	if ! hasField(entry, "year")
		@warn "No year field in entry \"$(entry.key)\"."
		return ""
	end

	return stringPy2Jl(entry.info.fields["year"])
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the journal where the publication was published.
"""
function getJournal(entry::BibEntry)
	if ! hasField(entry, "journal")
		@warn "No journal field in entry \"$(entry.key)\"."
		return ""
	end

	return stringPy2Jl(entry.info.fields["journal"])
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the volume of the publication.
"""
function getVolume(entry::BibEntry)
	return hasField(entry, "volume") ? stringPy2Jl(entry.info.fields["volume"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the number of the publication.
"""
function getNumber(entry::BibEntry)
	return hasField(entry, "number") ? stringPy2Jl(entry.info.fields["number"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the pages of the publication.
"""
function getPages(entry::BibEntry)
	return hasField(entry, "pages") ? stringPy2Jl(entry.info.fields["pages"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the edition of the publication.
"""
function getEdition(entry::BibEntry)
	return hasField(entry, "edition") ? stringPy2Jl(entry.info.fields["edition"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the electronic identifier of the publication.
"""
function getEId(entry::BibEntry)
	return hasField(entry, "eid") ? stringPy2Jl(entry.info.fields["eid"]) : ""
end
	

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the location of the publication.
"""
function getLocation(entry::BibEntry)
	return hasField(entry, "location") ? stringPy2Jl(entry.info.fields["location"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the publisher of the publication.
"""
function getPublisher(entry::BibEntry)
	if ! hasField(entry, "publisher")
		return ""
	end

	pub = stringPy2Jl(entry.info.fields["publisher"])

	return removeCurlyBracesLimiters(pub)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the DOI of the publication.
"""
function getDOI(entry::BibEntry)
	if ! hasField(entry, "doi")
		return ""
	end

	doi = stringPy2Jl(entry.info.fields["doi"])

	return removeCurlyBracesLimiters(doi)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
Get arXiv number, assuming it is in the eprint field.
"""
function getArXiv(entry::BibEntry)
	if ! hasField(entry, "eprint")
		return ""
	end

	arXiv = stringPy2Jl(entry.info.fields["eprint"])

	return removeCurlyBracesLimiters(arXiv)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the URL of the publication.
"""
function getURL(entry::BibEntry)
	if ! hasField(entry, "url")
		return ""
	end
	url = stringPy2Jl(entry.info.fields["url"])

	return removeCurlyBracesLimiters(url)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the ISBN of the publication.
"""
function getISBN(entry::BibEntry)
	isbn = hasField(entry, "isbn") ? stringPy2Jl(entry.info.fields["isbn"]) : ""
	return removeCurlyBracesLimiters(isbn)
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the ADS URL of the publication.
"""
function getADSURL(entry::BibEntry)
	if ! hasField(entry, "adsurl")
		return ""
	end

	url = stringPy2Jl(entry.info.fields["adsurl"])
	url = replace(url, "\\", "")

	return removeCurlyBracesLimiters(url)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the abstract of the publication, if available.
"""
function getAbstract(entry::BibEntry)
	return  hasField(entry, "abstract") ? string(entry.info.fields["abstract"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the keywords of the publication, if available.
"""
function getKeywords(entry::BibEntry)
	return  hasField(entry, "keywords") ? string(entry.info.fields["keywords"]) : ""
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the school of the publication, if available.
This is common for theses.
"""
function getSchool(entry::BibEntry)
	if ! hasField(entry, "school")
		@warn "No school field in entry \"$(entry.key)\"."
		return ""
	end

	return stringPy2Jl(entry.info.fields["school"])
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the file name(s) of the publication.
"""
function getFileName(entry::BibEntry, libraryFolder::String)
	if ! hasField(entry, "file")
		@warn "No file(s) available for \"$(entry.key)\"."
		return ""
	end

	s = stringPy2Jl(entry.info.fields["file"])
	f = split(s, ";")

	if length(f) == 1
		return f[1]
	else
		return f
	end
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the BibTeX representation of the entry.
"""
function getBibTeX(entry::BibEntry)
	return string(entry.info.to_string("bibtex"))
end


# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns all fields of a BibTeX entry.
"""
function getAllFields(entry::BibEntry)
	return keys(pyconvert(Dict, entry.info.fields))
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the number of authors of a BibTeX entry.
"""
function numberOfAuthors(entry::BibEntry)
	authors = getAuthors(entry)
	return length(authors)
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function returns the number of editors of a BibTeX entry.
"""
function numberOfEditors(entry::BibEntry)
	editors = getEditors(entry)
	return length(editors)
end

# ----------------------------------------------------------------------------------------------- #
#