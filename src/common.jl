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

function fixStrings(s::AbstractString)
	r = s
	for pair in hygenicDict
		r = replace(r, pair)
	end

	return r
end


stringPy2Jl(s) = pyconvert(String, s)

