# Pybtex.jl Documentation

This library wraps the [pybtex](https://pybtex.org/) Python API so that Julia code can read, query, and rewrite BibTeX files without leaving the Julia REPL.

## Installation
1. Activate the project or add the package:
   ```julia
   using Pkg
   Pkg.add(; path = ".")  # when developing locally
   ```
2. Install the Python dependency:
   ```bash
   python -m pip install pybtex
   ```
3. Instantiate the Julia environment:
   ```bash
   julia --project=. -e 'using Pkg; Pkg.instantiate()'
   ```

## Usage overview
- Use `readBibtexDataBase("path/to/file.bib")` to load a `.bib` file into a `BibLibrary`.
- Fetch entries with `getEntry(library, "key")` and inspect fields with utilities such as `getTitle`, `getJournal`, `getDOI`, `getFileName`, `getAllFields`, and `getBibTeX`.
- When a field is missing, the helpers return an empty string instead of throwing (except `getBookTitle`, which currently assumes the `booktitle` field exists).
- Print entries or libraries directly; the custom `Base.show` implementations format the most common fields nicely.

## Key APIs
| Function | Description |
| --- | --- |
| `readBibtexDataBase(path)` | Load a BibTeX file into a `BibLibrary`. |
| `writeBibtexDataBase(library, path)` | Serialize the library back to BibTeX while cleaning up LaTeX escapes. |
| `getEntry(library, key)` | Wrap a single entry as a `BibEntry` typed by its BibTeX `type`. |
| `getTitle`, `getJournal`, `getYear`, `getDOI` | Field helpers that clean braces and `\` escape sequences. |
| `getAuthors`, `getEditors` | Return vectors of `PersonName` records derived from pybtex persons. |
| `getFileName(entry; libraryFolder="")` | Normalize BibTeX `file` entries into Julia paths. |
| `getBibTeX(entry)` | Re-export the entry back to its BibTeX string. |
| `getAllFields(entry)` | List all defined fields for an entry. |

## Examples and sample data
- See `examples/examples.jl` for a quick demonstration of how the library is used.
- The accompanying sample database (`examples/sample.bib`) exercises the major entry helpers.

## Testing
- Run the bundled tests with:
  ```bash
  julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.test()'
  ```
- The tests live under `test/runtests.jl` and require the `pybtex` Python package in the active Python environment.

## Continuous integration
- GitHub Actions run the same test command inside `.github/workflows/ci.yml` on every push and pull request.
- The workflow also installs `pybtex` via `pip`, so the Julia job has the required Python dependency.
