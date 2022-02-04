module PGLib

using PowerModels
using Artifacts

# include("data.jl")


const PGLib_opf = joinpath(artifact"PGLib_opf","pglib-opf-21.07")


"""
    `pglib(fname::AbstractString)`

    open a matpower case file from the IEEE PGlib opf libray.  If the exact file
    cannot be found, then the cases will be filtered.  If a single case
    contains the name, it will be opened.
"""
function pglib(fname::AbstractString)
    if isfile(joinpath(PGLib_opf, fname))
        case = PowerModels.parse_file(joinpath(PGLib_opf, fname))
    elseif isfile(joinpath(PGLib_opf, "$fname.m"))
        case = PowerModels.parse_file(joinpath(PGLib_opf, "$fname.m"))
    elseif isfile(joinpath(PGLib_opf, "pglib_opf_$fname"))
        @info "opening case `pglib_opf_$fname`"
        case = PowerModels.parse_file(joinpath(PGLib_opf, "pglib_opf_$fname"))
    elseif isfile(joinpath(PGLib_opf, "pglib_opf_$fname.m"))
        @info "opening case `pglib_opf_$fname.m`"
        case = PowerModels.parse_file(joinpath(PGLib_opf, "pglib_opf_$fname.m"))
    else
        # if single case contains name
        files = readdir(joinpath(PGLib_opf))
        filtered_files = filter(x-> occursin(fname,x) , files)
        if length(filtered_files)==1
            file=filtered_files[1]
            @info "opening case `$file`"
            case = PowerModels.parse_file(joinpath(PGLib_opf, file))
        else
            @warn "Case `$(fname)` was not found.  Try running `find_pglib_case(\"$fname\")` to find similar case names."
            return Dict{String,Any}()
        end
    end
    return case
end

"""
    `find_pglib_case()`

    Return a list of all pglib case names.
"""
function find_pglib_case()
    return find_pglib_case("")
end


##TODO
# - add sort on number of nodes (size)
# - add sort on variation (api sad hvdc uc)
# - add type, and show method.  make accessing list of files easy.
"""
    `find_pglib_case(name::AbstractString)`

    Find all pglib cases that contain `name`.
"""
function find_pglib_case(name::AbstractString)
    files = readdir(PGLib_opf)
    filter!(x-> isfile(joinpath(PGLib_opf,x)) , files)  # filter for files
    filter!(x-> splitext(x)[2]==".m" , files)           # filter for .m files
    filtered_files = filter(x-> occursin(name,x) , files)

    return filtered_files
end

include("export.jl")

end # module



