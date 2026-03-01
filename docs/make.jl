using Documenter
using Pybtex

DocMeta.setdocmeta!(Pybtex, :DocTestSetup, :(using Pybtex); recursive = true)

makedocs(
    sitename = "Pybtex.jl",
    modules = [Pybtex],
    format   = Documenter.HTML(
		prettyurls = get(ENV, "CI", nothing) == "true",
	),
    pages = [
        "Home" => "index.md",
    ],
)

deploydocs(
	repo   = "github.com/rafaelab/Pybtex.jl.git",
	devbranch = "main",
)
