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
        n = length(dgms)
        ns = Array{Cint,1}(map(x->size(x,1), dgms))
        data = vcat(map(x->x'[:],dgms)...)
        ret = Ref{Array{Cdouble,1}}(-1*ones(Float64,Int(n*(n - 1)/2)))
        ccall((:bottlenecks, libhera),
            Void, (Cint, Ptr{Cint}, Ptr{Float64}, Ref{Array{Cdouble,1}}),
            n, ns, data, ret)
        m = getindex(ret)
        M,l = (zeros(Float64,n,n),0)
        for i=1:n,j=i+1:n
            M[i,j] = M[j,i] = m[l+=1]
        end
        M
    end

    function torus(n, R, r)
        t = rand(n,2)
        x = (R + r*cos.(2pi*t[:,1])).*cos.(2pi*t[:,2])
        y = (R + r*cos.(2pi*t[:,1])).*sin.(2pi*t[:,2])
        z = r*sin.(2pi*t[:,1])
        [x y z]
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
