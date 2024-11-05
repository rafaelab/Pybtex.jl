# ----------------------------------------------------------------------------------------------- #
#
@doc """
This function fixes the strings from the bibtex file.
"""
function removeCurlyBracesLimiters(s::AbstractString)
	r = s
	if r[1] == '{' && r[2] ≠ '\\'
		r = replace(r, "{" => "")
	end
	if r[end] == '}'
		r = replace(r, "}" => "")
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

