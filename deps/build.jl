using BinDeps

@BinDeps.setup

libhera = library_dependency("libhera")

URL = "https://bitbucket.org/grey_narn/hera.git"
SRC = "src/hera"
LIB = "usr/lib"
SUFF = is_apple() ? "dylib" : "so"
INC = "-I/usr/local/include/boost -I$SRC/geom_bottleneck/include"
CMD = if is_apple()
    [`g++ -std=c++11 -c src/hera.cpp $INC -o $LIB/hera.o`,
        `g++ -static-libstdc++ -dynamiclib -fPIC $INC -o $LIB/libhera.$SUFF $LIB/hera.o`]
else
    [`gcc -c -fPIC $INC src/hera.cpp -o $LIB/hera.o`,
        `gcc $LIB/hera.o -shared -o $LIB/libhera.$SUFF`]
end

provides(BuildProcess, (@build_steps begin
    !("hera" in readdir("src")) ? run(`git clone $URL $SRC`) : println("$SRC exists")
    mkpath(LIB)
    @build_steps begin FileRule(joinpath("usr","lib","libhera.$SUFF"),
        @build_steps begin
            CMD[1]
            CMD[2]
        end)
    end
end), libhera)

@BinDeps.install Dict(:libhera => :libhera)
