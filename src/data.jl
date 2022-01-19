
const URL = "https://github.com/power-grid-lib/pglib-opf/raw/master/"

files = String[]
open(joinpath(@__DIR__,"opf_files.txt"),"r") do io
    for file in eachline(io)
        push!(files, file)
    end
end

function __init__()
    register(DataDep(
    "PGLib_opf",
    """
        Dataset: Power Grid Lib - Optimal Power Flow
        Website: https://github.com/power-grid-lib/pglib-opf
        Author: IEEE PES Task Force on Benchmarks for Validation of Emerging Power System Algorithms

        Data License:

        Creative Commons Attribution 4.0 International license
        http://creativecommons.org/licenses/by/4.0/

        See data files for specific copyright holders and attribution details.
        """,
        URL .* files,
        "2d0f062e056d36f6f5a719d49762850baad069c9912710318780700ca3c5e71f"
    ))
end