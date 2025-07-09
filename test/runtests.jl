
using PGLib
using PowerModels
using Test

silence() #suppress PowerModels output

case = parse_file(joinpath("./pglib_opf_case3_lmbd.m"))
case_api = parse_file(joinpath("./pglib_opf_case3_lmbd__api.m"))
case_sad = parse_file(joinpath("./pglib_opf_case3_lmbd__sad.m"))


@testset "pglib" begin
    @testset "open pglib case file" begin
        @test case == pglib("pglib_opf_case3_lmbd.m")
        @test case == pglib("pglib_opf_case3_lmbd")
        @test case == pglib("case3_lmbd.m")
        @test case == pglib("case3_lmbd")
        @test case == pglib("lmbd")

        @test case_api == pglib("lmbd","api")
        @test case_sad == pglib("lmbd","sad")
    end

    @testset "find pglib case" begin
        @test ["pglib_opf_case3_lmbd.m"] == find_pglib_case("lmbd")
        @test ["pglib_opf_case3_lmbd__api.m"] == find_pglib_case("lmbd","api")
        @test ["pglib_opf_case3_lmbd__sad.m"] == find_pglib_case("lmbd","sad")
        @test length(find_pglib_case()) == 66
        @test length(find_pglib_case("","sad")) == 66
        @test length(find_pglib_case("","api")) == 66
    end

    @testset "parse filename for buses" begin
        @test pglib_buscount("pglib_opf_case3_lmbd.m") == 3
        @test pglib_buscount("pglib_opf_case2736sp_k.m") == 2736
    end

    @testset "test bad names" begin
        @test_throws ErrorException pglib_buscount("CASE123")
        @test_throws ErrorException pglib_buscount("pglib_opf_caseonehundred")
    end
end
