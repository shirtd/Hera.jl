using BinDeps

@BinDeps.setup

if !("hera" in readdir("src"))
    run(`git clone https://bitbucket.org/grey_narn/hera.git src/hera`)
end

mkpath("usr/lib")
INC = "-Isrc/hera/geom_bottleneck/include"
run(`g++ -c src/hera.cpp $INC -o usr/lib/hera.o`)
run(`g++ -static-libstdc++ -dynamiclib -fPIC $INC -o usr/lib/libhera.dylib usr/lib/hera.o`)

libhera = library_dependency("libhera")
