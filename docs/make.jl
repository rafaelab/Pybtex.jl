using Documenter
using Pybtex

DocMeta.setdocmeta!(Pybtex, :DocTestSetup, :(using Pybtex); recursive = true)

makedocs(
    sitename = "Pybtex.jl",
    modules = [Pybtex],
    pages = [
        "Home" => "index.md",
    ],
)

repo_env = get(ENV, "GITHUB_REPOSITORY", "")
if !isempty(repo_env)
    deploydocs(
        repo = "github.com/$(repo_env).git",
        devbranch = get(ENV, "DOCUMENTER_DEVBRANCH", "main"),
        push_preview = true,
    )
end
