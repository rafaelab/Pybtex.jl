# Pybtex.jl

Pybtex.jl is a small Julia wrapper around [pybtex](https://pybtex.org/) that makes it easy to read, inspect, and rewrite BibTeX data without leaving the Julia REPL.

## Installation
1. Add the package to your environment (or point to a local checkout while developing):
   ```julia
   using Pkg
   Pkg.add(; path = ".")
   ```
2. Install the Python dependency:
   ```bash
   python -m pip install pybtex
   ```
3. Instantiate the Julia environment and grab the dependencies:
   ```bash
   julia --project=. -e 'using Pkg; Pkg.instantiate()'
   ```

## Usage
```julia
using Pybtex

library = readBibtexDataBase("examples/sample.bib")
entry = getEntry(library, "sample")
println(getTitle(entry))
println(getJournal(entry))
println(getAuthors(entry)[1])
```

The package exports helpers such as `getTitle`, `getJournal`, `getDOI`, `getFileName`, and `getBibTeX` so you can query the metadata you care about without touching the Python API directly.

## Documentation
Full documentation and API notes live in `docs/README.md`.

## Testing
Install the Python dependency and run the bundled tests:
```bash
python -m pip install pybtex
julia --project=. -e 'using Pkg; Pkg.test()'
```

## Examples
Play with `examples/examples.jl` to see a minimal script, and inspect `examples/sample.bib` for a sample BibTeX entry.

## Known problems
- Accents are not working very well.
