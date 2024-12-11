using TemporaryArrays
using Documenter

DocMeta.setdocmeta!(TemporaryArrays, :DocTestSetup, :(using TemporaryArrays); recursive=true)

makedocs(;
    modules=[TemporaryArrays],
    authors="Kyle Sherbert <kyle.sherbert@vt.edu> and contributors",
    sitename="TemporaryArrays.jl",
    format=Documenter.HTML(;
        canonical="https://kmsherbertvt.github.io/TemporaryArrays.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/kmsherbertvt/TemporaryArrays.jl",
    devbranch="main",
)
