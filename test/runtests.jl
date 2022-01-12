
using PGLIB
using PowerModels
using Test

case = parse_file(joinpath(@__DIR__, "..", "data", "pglib_opf_case3_lmbd.m"))

@test case == pglib("pglib_opf_case3_lmbd.m")
@test case == pglib("pglib_opf_case3_lmbd")
@test case == pglib("case3_lmbd.m")
@test case == pglib("case3_lmbd")
@test case == pglib("lmbd")

@test ["pglib_opf_case3_lmbd.m"] == find_pglib_case("lmbd")
@test length(find_pglib_case()) == 59