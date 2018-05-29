__precompile__(true)

module Hera

    const depsfile = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
    if isfile(depsfile)
        include(depsfile)
    else
        error("Hera not properly installed. Please run Pkg.build(\"Hera\") then restart Julia.")
    end

    function bottleneck(A,B)
        ccall((:bottleneck, libhera),
            Float64,(Cint, Cint, Ptr{Float64}, Ptr{Float64}),
            size(A,1), size(B,1), A'[:], B'[:])
    end

    test() = bottleneck([0.0 1.0; 2.0 3.0; 4.0 5.0],[0.0 1.0; 1.0 2.0; 3.0 4.0])

    export bottleneck

end
