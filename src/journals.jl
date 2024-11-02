journalsAbbreviations = Dict{String, String}(
	"aap" => "Astron. Astrophys.",
	"aj" => "Astron. J.",
	"actaa" => "Acta Astron.",
	"apj" => "Astrophys. J.",
	"apjl" => "Astrophys. J. Lett.",
	"apjs" => "Astrophys. J. Suppl.",
	"apss" => "Astrophys. Space Sci.",
	"ao" => "Appl. Opt.",
	"araa" => "Annu. Rev. Astron. Astrophys.",
	"azh" => "Astron. Zh.",
	"baas" => "Bull. Am. Astron. Soc.",
	"caa" => "Chin. Astron. Astrophys.",
	"cjaa" => "Chin. J. Astron. Astrophys.",
	"gca" => "Geochim. Cosmochim. Acta",
	"grl" => "Geophys. Res. Lett.",
	"icarus" => "Icarus",
	"memras" => "Mem. R. Astron. Soc.",
	"mnras" => "Mon. Not. R. Astron. Soc.",
	"qjras" => "Q. J. R. Astron. Soc.",
	"jcap" => "J. Cosmol. Astropart. Phys.",
	"jgr" => "J. Geophys. Res.",
	"na" => "New Astron.",
	"nar" => "New Astron. Rev.",
	"nat" => "Nature",
	"nphys" => "Nature Phys.",
	"pasa" => "Publ. Astron. Soc. Aust.",
	"pasp" => "Publ. Astron. Soc. Pac.",
	"pasj" => "Publ. Astron. Soc. Jpn.",
	"phlb" => "Phys. Lett. B",
	"physrep" => "Phys. Rep.",
	"physscr" => "Phys. Scr.",
	"prl" => "Phys. Rev. Lett.",
	"pra" => "Phys. Rev. A",
	"prb" => "Phys. Rev. B",
	"prc" => "Phys. Rev. C",
	"prd" => "Phys. Rev. D",
	"pre" => "Phys. Rev. E",
	"prx" => "Phys. Rev. X",
	"rmp" => "Rev. Mod. Phys.",	
	"sci" => "Science",
	"solphys" => "Solar Phys.",
	"sovast" => "Sov. Astron.",
	"ssr" => "Space Sci. Rev.",
	)

journalFullNames = Dict{String, String}(
	"aap" => "Astronomy and Astrophysics",
	"aj" => "Astronomical Journal",
	"actaa" => "Acta Astronomica",
	"apj" => "Astrophysical Journal",
	"apjl" => "Astrophysical Journal Letters",
	"apjs" => "Astrophysical Journal Supplement",
	"apss" => "Astrophysics and Space Science",
	"ao" => "Applied Optics",
	"araa" => "Annual Review of Astronomy and Astrophysics",
	"azh" => "Astronomicheskii Zhurnal",
	"baas" => "Bulletin of the American Astronomical Society",
	"caa" => "Chinese Astronomy and Astrophysics",
	"cjaa" => "Chinese Journal of Astronomy and Astrophysics",
	"gca" => "Geochimica et Cosmochimica Acta",
	"grl" => "Geophysical Research Letters",
	"icarus" => "Icarus",
	"memras" => "Memoirs of the Royal Astronomical Society",
	"mnras" => "Monthly Notices of the Royal Astronomical Society",
	"qjras" => "Quarterly Journal of the Royal Astronomical Society",
	"jcap" => "Journal of Cosmology and Astroparticle Physics",
	"jgr" => "Journal of Geophysical Research",
	"na" => "New Astronomy",
	"nar" => "New Astronomy Reviews",
	"nat" => "Nature",
	"nphys" => "Nature Physics",
	"pasa" => "Publications of the Astronomical Society of Australia",
	"pasp" => "Publications of the Astronomical Society of the Pacific",
	"pasj" => "Publications of the Astronomical Society of Japan",
	"phlb" => "Physics Letters B",
	"physrep" => "Physics Reports",
	"physscr" => "Physica Scripta",
	"prl" => "Physical Review Letters",
	"pra" => "Physical Review A",
	"prb" => "Physical Review B",
	"prc" => "Physical Review C",
	"prd" => "Physical Review D",
	"pre" => "Physical Review E",
	"prx" => "Physical Review X",
	"rmp" => "Reviews of Modern Physics",
	"sci" => "Science",
	"solphys" => "Solar Physics",
	"sovast" => "Soviet Astronomy",
	"ssr" => "Space Science Reviews",
)


function journalAbbreviationFromTag(tag::String)
	if haskey(journalsAbbreviations, tag)
		return journalsAbbreviations[tag]
	else
		@warn "Journal abbreviation not found for tag \"$tag\". Returning empty string."
		return ""
	end
end

function journalFullNameFromTag(tag::String)
	if haskey(journalFullNames, tag)
		return journalFullNames[tag]
	else
		@warn "Journal full name not found for tag \"$tag\". Returning empty string."
		return ""
	end
end

function journalTagFromFullName(fullName::String)
	# exceptions
	correctionDict = Dict{String, String}(
		"Astronomy & Astrophysics" => "Astronomy and Astrophysics",
		"Astronomy \\& Astrophysics" => "Astronomy and Astrophysics",
		)

	journalName = fullName
	if haskey(correctionDict, fullName)
		journalName = correctionDict[fullName]
	end

	for (tag, name) in journalFullNames
		if name == journalName
			return tag
		end
	end

	@warn "Journal tag not found for full name \"$fullName\". Returning empty string."
	return ""
end