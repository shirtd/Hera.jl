__precompile__(true)
module Hera

    export bottleneck

    function bottleneck(A,B)
        ccall((:bottleneck, libhera),
            Float64,(Cint, Cint, Ptr{Float64}, Ptr{Float64}),
            size(A,1), size(B,1), A'[:], B'[:])
    end

end
