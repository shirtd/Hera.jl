__precompile__(true)
module Hera

    export bottleneck

    bottleneck(A,B) = ccall((:bottleneck, "deps/usr/lib/libhera"),
            Float64,(Cint, Cint, Ptr{Float64}, Ptr{Float64}),
            size(A,1), size(B,1), A'[:], B'[:])

end
