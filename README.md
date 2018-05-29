# Hera.jl

A Julia wrapper for computing the Bottleneck distance using Hera.

    https://bitbucket.org/grey_narn/hera

## Build

Hera requires Boost.

On OSX, with Homebrew

    brew install boost

... on Linux

    sudo apt install libboost-all-dev

then, from Julia

    Pkg.clone("https://github.com/shirtd/Hera.jl.git")
    Pkg.build("Hera")

To test,

    using Hera
    Hera.test() == 0.5
