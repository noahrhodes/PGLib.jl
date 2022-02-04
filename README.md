# PGLib.jl

Status:
[![CI](https://github.com/noahrhodes/PGLib.jl/workflows/CI/badge.svg)](https://github.com/noahrhodes/PGLib.jl/actions?query=workflow%3ACI)
[![codecov](https://codecov.io/gh/noahrhodes/PGLib.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/noahrhodes/PGLib.jl)
</p>

PGLib.jl provides easy access to the [Optimal Power Flow benchmark library](https://github.com/power-grid-lib/pglib-opf) provided by the [IEEE PES Task Force on Benchmarks for Validation of Emerging Power System Algorithms](https://power-grid-lib.github.io/).

## Documentation

`pglib(case_file)` opens the case file.  The case file name can be approximate:

```julia
 pglib("pglib_opf_case3_lmbd.m")  #full file name
 pglib("pglib_opf_case3_lmbd")    #file name without extension
 pglib("case3_lmbd.m")            #case name without pglib_opf prepended
 pglib("case3_lmbd")              #only the case name
 pglib("lmbd")                    #a unique case is identified, so it can be opened
```

`find_pglib_case("case_name")` searches the benchmark cases for a matching string name.

```julia
julia> find_pglib_case("ieee")
8-element Vector{String}:
 "pglib_opf_case118_ieee.m"
 "pglib_opf_case14_ieee.m"
 "pglib_opf_case162_ieee_dtc.m"
 "pglib_opf_case24_ieee_rts.m"
 "pglib_opf_case300_ieee.m"
 "pglib_opf_case30_ieee.m"
 "pglib_opf_case57_ieee.m"
 "pglib_opf_case73_ieee_rts.m"

julia> find_pglib_case("500")
1-element Vector{String}:
 "pglib_opf_case500_goc.m"
 ```

 Case variations can be found by including a second argument to specify the problem variation.
 ```julia
pglib("case3_lmbd","sad")
pglib("case3_lmbd","api")
```
```julia
julia> find_pglib_case("500","api")
1-element Vector{String}:
 "pglib_opf_case500_goc__api.m"
 ```
