using Artifacts, ArtifactUtils

# update to newest version of PGLIB to create new artifact
# Example at ArtifactUtils.jl github
add_artifact!(
    "Artifacts.toml",
    "PGLib_opf",
    "https://github.com/power-grid-lib/pglib-opf/archive/refs/tags/v23.07.tar.gz",
    force=true,
)