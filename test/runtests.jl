
using PGLIB
using PowerModels
using DataDeps
using Test

ENV["DATADEPS_ALWAYS_ACCEPT"] = true

case = parse_file(joinpath("./pglib_opf_case3_lmbd.m"))


@testset "pglib" begin
    @testset "open pglib case file" begin
        @test case == pglib("pglib_opf_case3_lmbd.m")
        @test case == pglib("pglib_opf_case3_lmbd")
        @test case == pglib("case3_lmbd.m")
        @test case == pglib("case3_lmbd")
        @test case == pglib("lmbd")
    end

    @testset "find pglib case" begin
        @test ["pglib_opf_case3_lmbd.m"] == find_pglib_case("lmbd")
        @test length(find_pglib_case()) == 59
    end
end