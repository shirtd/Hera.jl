# Hera.jl

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
