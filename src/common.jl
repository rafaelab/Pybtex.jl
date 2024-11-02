# ----------------------------------------------------------------------------------------------- #
#
"""
This dictionary is used to clean up the strings from the bibtex file.
It is used to remove the latex commands and other unwanted characters.
"""
hygenicDict = Dict{String, String}(
	"{" => "",
	"}" => "",
	"\\\\\\\\\\" => "\\",
	"\\\\\\\\" => "\\",
	"\\\\\\" => "\\",
	"\\\\" => "\\",
	"\\" => "",
	"\\\\&" => "\\&",
	"\\\$" => "\$",
)

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function fixes the strings from the bibtex file.
"""
function fixStrings(s::AbstractString)
	r = s
	for pair in hygenicDict
		r = replace(r, pair)
	end

	return r
end

# ----------------------------------------------------------------------------------------------- #
#
@doc """
This unexported function converts a python string to a julia string.
"""
stringPy2Jl(s) = pyconvert(String, s)


# ----------------------------------------------------------------------------------------------- #
#

