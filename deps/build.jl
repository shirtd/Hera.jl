using BinDeps

@BinDeps.setup

libhera = library_dependency("libhera")

if !("hera" in readdir("src"))
    run(`git clone https://bitbucket.org/grey_narn/hera.git src/hera`)
end

mkpath("usr/lib")
INC = "-Isrc/hera/geom_bottleneck/include"
provides(BuildProcess, (@build_steps begin
    @build_steps begin
        FileRule(joinpath("usr","lib","libhera.dylib"), @build_steps begin
            `g++ -c src/hera.cpp $INC -o usr/lib/hera.o`
            `g++ -static-libstdc++ -dynamiclib -fPIC $INC -o usr/lib/libhera.dylib usr/lib/hera.o`
        end)
    end
end), libhera)

# mkpath("usr/lib")
# run(`g++ -c src/hera.cpp $INC -o usr/lib/hera.o`)
# run(`g++ -static-libstdc++ -dynamiclib -fPIC $INC -o usr/lib/libhera.dylib usr/lib/hera.o`)

@BinDeps.install Dict(:libhera => :libhera)
