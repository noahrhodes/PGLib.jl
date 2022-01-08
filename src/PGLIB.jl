module PGLIB

using PowerModels

function pglib(name::AbstractString)
    if isfile(joinpath(@__DIR__, "..", "data", name))
        case = PowerModels.parse_file(joinpath(@__DIR__, "..", "data", name))
    elseif isfile(joinpath(@__DIR__, "..", "data", "$name.m"))
        case = PowerModels.parse_file(joinpath(@__DIR__, "..", "data", "$name.m"))
    elseif isfile(joinpath(@__DIR__, "..", "data", "pglib_opf_$name"))
        @info "opening case `pglib_opf_$name`"
        case = PowerModels.parse_file(joinpath(@__DIR__, "..", "data", "pglib_opf_$name"))
    elseif isfile(joinpath(@__DIR__, "..", "data", "pglib_opf_$name.m"))
        @info "opening case `pglib_opf_$name.m`"
        case = PowerModels.parse_file(joinpath(@__DIR__, "..", "data", "pglib_opf_$name.m"))
    else
        @warn "Case `$(name)` was not found.  Try running `find_pglib_case($name)` to find similar case names."
        return Dict{String,Any}()
    end
    return case
end


function find_pglib_case()
    return find_pglib_case("")
end


##TODO
# - add sort on number of nodes (size)
# - add sort on variation (api sad hvdc uc)
# - add type, and show method.  make accessing list of files easy.
function find_pglib_case(name::AbstractString)
    files = readdir(joinpath(@__DIR__, "..", "data"))
    filtered_files = filter(x-> occursin(name,x) , files)

    return filtered_files
end

include("export.jl")

end # module



