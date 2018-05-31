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

## Usage

For any n x 2 array A and m x 2 array B the bottleneck distance can be computed as

    bottleneck(A, B)

For an array of D n persistence diagrams in the above format the n x n distance matrix of all pairwise bottleneck distances between them can be computed as

    bottlenecks(D)
