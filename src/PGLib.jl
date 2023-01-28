module PGLib

using PowerModels
using Artifacts
using StringDistances

# include("data.jl")


const PGLib_opf = joinpath(artifact"PGLib_opf","pglib-opf-21.07")
const PGLib_opf_api = joinpath(artifact"PGLib_opf","pglib-opf-21.07","api")
const PGLib_opf_sad = joinpath(artifact"PGLib_opf","pglib-opf-21.07","sad")

function pglib(fname::AbstractString, variant::AbstractString)
    if variant=="api"
        return _pglib(fname,PGLib_opf_api)
    elseif variant=="sad"
        return _pglib(fname,PGLib_opf_sad)
    else
        @error "pglib variation $variant is not available."
    end
end

function pglib(fname::AbstractString)
    return _pglib(fname,PGLib_opf)
end


""
function _pglib(fname::AbstractString, path::AbstractString)
    files = readdir(joinpath(PGLib_opf))
    filter!(f->isfile(joinpath(PGLib_opf,f)), files)
    filter!(f->endswith(f,".m"), files)

    filtered_files = filter(x-> occursin(fname,x) , files)

    if length(filtered_files)==1 # if single case contains name
        file=filtered_files[1]
        @info "opening case `$file`"
        case = PowerModels.parse_file(joinpath(PGLib_opf, file))
    else # fuzzy string match search
        dist = [evaluate(TokenMax(NMD(1)), fname, f) for f in files] #length(fname)
        p = sortperm(dist)
        dist = dist[p]
        files = files[p]
        count=0
        warn_msg = "Unique case `$(fname)` was not found. Here are some similar case names to \"$fname\":\n"
        for idx in eachindex(files)
            if dist[idx] < 10 && count <= 10
                warn_msg *= " - $(files[idx])\n"
                count+=1
            else
                break
            end
        end
        warn_msg *= "You can also try running `find_pglib_case(\"$fname\")` to find explore matching case names."
        @warn warn_msg
        case=Dict{String,Any}()
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
    return _find_pglib_case(name, PGLib_opf)
end


""
function find_pglib_case(name::AbstractString, variant::AbstractString)
    if variant=="api"
        return _find_pglib_case(name,PGLib_opf_api)
    elseif variant=="sad"
        return _find_pglib_case(name,PGLib_opf_sad)
    else
        @error "pglib variation $variant is not available."
    end
end


""
function _find_pglib_case(name::AbstractString, path::AbstractString)
    files = readdir(path)
    filter!(x-> isfile(joinpath(path,x)) , files)  # filter for files
    filter!(x->endswith(x,".m"), files)           # filter for .m files

    filtered_files = filter(x-> occursin(name,x) , files) # exact match
    return filtered_files
end


include("export.jl")
end # module