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

    function bottlenecks(dgms)
        @show n = length(dgms)
        ns = Array{Cint,1}(map(x->size(x,1), dgms))
        data = vcat(map(x->x'[:],dgms)...)
        @show ns
        @show data
        m = Int(n*(n - 1)/2)
        ret = Ref{Array{Cdouble,1}}(-1*ones(Float64,m))
        # ret = Vector{Cdouble}(m)
        ccall((:bottlenecks, libhera),
            Void, (Cint, Ptr{Cint}, Ptr{Float64}, Ref{Array{Cdouble,1}}),
            # Void, (Cint, Ptr{Cint}, Ptr{Float64}, Ref{Cdouble}),
            n, ns, data, ret)
        getindex(ret)
    end

    function test()
        data = [[0.0 1.0; 2.0 3.0; 4.0 5.0],
                [0.0 1.0; 1.0 2.0; 3.0 4.0],
                [0.0 2.0; 0.0 3.0; 1.0 2.0]]
        @show bottleneck(data[1],data[2])
        @show bottleneck(data[1],data[3])
        @show bottleneck(data[2],data[3])
        @show bottlenecks(data)
    end

    export bottleneck, bottlenecks

end
