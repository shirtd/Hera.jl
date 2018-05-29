function atorus(n,R,r)
    seed = rand(n,2)
    x = (R + r*cos.(2pi*seed[:,1])).*cos.(2pi*seed[:,2])
    y = (R + r*cos.(2pi*seed[:,1])).*sin.(2pi*seed[:,2])
    z = r*sin.(2pi*seed[:,1])
    [x y z]
end

include("../src/Hera.jl")
using Eirene, Hera

println("generating tori")
x = atorus(100,1.0,0.3)
y = atorus(100,0.7,0.2)

println("running eirene")
@time X = barcode(eirene(x',model="pc",maxdim=1))
@time Y = barcode(eirene(y',model="pc",maxdim=1))

println("computing bottleneck distance")
@time @show bottleneck(X,Y)
