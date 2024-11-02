struct BibEntry
	key::String
	info::Py
end


hasField(entry::BibEntry, field::String) = haskey(pyconvert(Dict, entry.info.fields), lowercase(field))

getEntry(bib::BibLibrary, key) = BibEntry(key, bib.entries[key])

function getType(entry::BibEntry) 
	s = stringPy2Jl(entry.info.type)
	return lowercase(s)
end

function getAuthors(entry::BibEntry)
	authors = entry.info.persons["author"]
	names = []

	for author in authors
		name = pybtexToPersonName(author)
		push!(names, name)
	end

	return names
end

function getEditors(entry::BibEntry)
	authors = entry.info.persons["editors"]
	names = []

	for author in authors
		name = pybtexToName(author)
		push!(names, name)
	end

	return names
end

function getTitle(entry::BibEntry)
	if ! hasField(entry, "title")
		@warn "No title field in entry \"$(entry.key)\"."
		return ""
	end

	s = entry.info.fields["title"]
	s = stringPy2Jl(s)
	return fixStrings(s)
end

function getYear(entry::BibEntry)
	if ! hasField(entry, "year")
		@warn "No year field in entry \"$(entry.key)\"."
		return ""
	end

	return stringPy2Jl(entry.info.fields["year"])
end

function getJournal(entry::BibEntry)
	if ! hasField(entry, "journal")
		@warn "No journal field in entry \"$(entry.key)\"."
		return ""
	end

	return stringPy2Jl(entry.info.fields["journal"])
end

function getVolume(entry::BibEntry)
	return hasField(entry, "volume") ? stringPy2Jl(entry.info.fields["volume"]) : ""
end

function getNumber(entry::BibEntry)
	return hasField(entry, "number") ? stringPy2Jl(entry.info.fields["number"]) : ""
end

function getPages(entry::BibEntry)
	return hasField(entry, "pages") ? stringPy2Jl(entry.info.fields["pages"]) : ""
end

function getEdition(entry::BibEntry)
	return hasField(entry, "edition") ? stringPy2Jl(entry.info.fields["edition"]) : ""
end

function getLocation(entry::BibEntry)
	return hasField(entry, "location") ? stringPy2Jl(entry.info.fields["location"]) : ""
end

function getPublisher(entry::BibEntry)
	return hasField(entry, "publisher") ? stringPy2Jl(entry.info.fields["publisher"]) : ""
end

function getDOI(entry::BibEntry)
	return hasField(entry, "doi") ? stringPy2Jl(entry.info.fields["doi"]) : ""
end

function getURL(entry::BibEntry)
	return hasField(entry, "url") ? stringPy2Jl(entry.info.fields["url"]) : ""
end

function getAbstract(entry::BibEntry)
	return  hasField(entry, "abstract") ? string(entry.info.fields["abstract"]) : ""
end

function getKeywords(entry::BibEntry)
	return  hasField(entry, "keywords") ? string(entry.info.fields["keywords"]) : ""
end

function getBibTeX(entry::BibEntry)
	return string(entry.info.to_string("bibtex"))
end

