
using PGLIB
using PowerModels
using Test

case = parse_file(joinpath(@__DIR__, "..", "data", "pglib_opf_case3_lmbd.m"))

@test case == pglib("pglib_opf_case3_lmbd.m")
@test case == pglib("pglib_opf_case3_lmbd")
@test case == pglib("case3_lmbd.m")
@test case == pglib("case3_lmbd")