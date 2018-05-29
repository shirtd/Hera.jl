# Hera.jl

Hera requires Boost.
On Linux

    sudo apt install libboost-all-dev

Building the Hera library requires g++

    sudo apt install g++

Then, from Julia

    Pkg.clone("https://github.com/shirtd/Hera.jl.git")
    Pkg.build("Hera")
