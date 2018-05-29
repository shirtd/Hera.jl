# Hera.jl

Building the Hera library requires g++
On Linux

    sudo apt install g++

On OSX, download using XCode.

Hera requires Boost.

On OSX, with Homebrew

    brew install boost

On Linux

    sudo apt install libboost-all-dev

Then, from Julia

    Pkg.clone("https://github.com/shirtd/Hera.jl.git")
    Pkg.build("Hera")
