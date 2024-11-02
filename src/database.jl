struct BibLibrary
	db
end



Base.length(db::BibLibrary) = length(db.entries.keys())

Base.getindex(db::BibLibrary, key) = db.entries[key]

Base.keys(db::BibLibrary) = keys(db.entries)

function Base.getproperty(bib::BibLibrary, v::Symbol)
	if v == :entries
		return bib.db.entries
	else
		return getfield(bib, v)
	end
end


function readBibtexDataBase(filename::String)
	d = pyimport("pybtex.database").parse_file(filename)
	return BibLibrary(d)
end