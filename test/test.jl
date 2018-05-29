include("../src/Hera.jl")
using Hera

X = [0.0 1.0; 2.0 3.0; 4.0 5.0]
Y = [0.0 1.0; 1.0 2.0; 3.0 4.0]

@show bottleneck(X,Y)
