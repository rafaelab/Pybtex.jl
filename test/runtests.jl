using Test
using Pybtex

import Pybtex: removeCurlyBracesLimiters


const SAMPLE_BIB = joinpath(@__DIR__, "..", "examples", "sample.bib")

function loadSampleEntry()
    library = readBibtexDataBase(SAMPLE_BIB)
    return getEntry(library, "sample"), library
end

@testset "Entry metadata" begin
    entry, _ = loadSampleEntry()

    @test occursin("Zur Elektrodynamik bewegter", getTitle(entry))
    @test getJournal(entry) == "Annalen der Physik"
    @test getYear(entry) == "1905"
    @test hasField(entry, "doi")
    @test getDOI(entry) == "10.1002/andp.19053221004"
    @test ! hasField(entry, "publisher")
    @test getURL(entry) == ""
    @test occursin("@ARTICLE", getBibTeX(entry))
    @test "title" ∈ getAllFields(entry)
end

@testset "Person helpers" begin
    entry, _ = loadSampleEntry()
    authors = getAuthors(entry)

    @test length(authors) == 1
    author = authors[1]
    @test author.firstName == "A."
    @test author.lastName == "Einstein"
end

@testset "URL and file helpers" begin
    entry, _ = loadSampleEntry()

    entry.info.fields["adsurl"] = raw"\https://example.test/path"
    @test getADSURL(entry) == "https://example.test/path"

    entry.info.fields["file"] = ":paper.pdf:PDF"
    file_path = getFileName(entry, libraryFolder = "/tmp")
    @test file_path == joinpath("/tmp", "paper.pdf")

    entry.info.fields["file"] = ":first.pdf:PDF;:second.pdf:PDF"
    files = getFileName(entry, libraryFolder = "/tmp")
    @test files == [joinpath("/tmp", "first.pdf"), joinpath("/tmp", "second.pdf")]
end

@testset "Database output" begin
    entry, library = loadSampleEntry()
    entry.info.fields["title"] = "ABC"

    output_dir = mktempdir()
    output_file = joinpath(output_dir, "clean.bib")
    writeBibtexDataBase(library, output_file)

    output = read(output_file, String)
    @test occursin("ABC", output)
end

@testset "Helpers" begin
    @test removeCurlyBracesLimiters("{value}") == "value"
end
