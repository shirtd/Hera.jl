__precompile__(true)

module Hera

    libhera = joinpath(dirname(@__FILE__),"..","deps","usr","lib","libhera")

    function bottleneck(A,B)
        ccall((:bottleneck, libhera),
            Float64,(Cint, Cint, Ptr{Float64}, Ptr{Float64}),
            size(A,1), size(B,1), A'[:], B'[:])
    end

    export bottleneck

end
