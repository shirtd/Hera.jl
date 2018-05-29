using BinDeps

@BinDeps.setup

libhera = library_dependency("libhera")

URL = "https://bitbucket.org/grey_narn/hera.git"
SRC = "src/hera"
LIB = "usr/lib"
SUFF = is_apple() ? "dylib" : "so"
INC = "-I$SRC/geom_bottleneck/include"
provides(BuildProcess, (@build_steps begin
    !("hera" in readdir("src")) ? run(`git clone $URL $SRC`) : println("$SRC exists")
    mkdir(LIB)
    @build_steps begin FileRule(joinpath("usr","lib","libhera.$SUFF"),
        @build_steps begin
            `g++ -c src/hera.cpp $INC -o $LIB/hera.o`
            `g++ -static-libstdc++ -dynamiclib -fPIC $INC -o $LIB/libhera.$SUFF $LIB/hera.o`
        end)
    end
end), libhera)

@BinDeps.install Dict(:libhera => :libhera)
