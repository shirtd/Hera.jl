using BinDeps

@BinDeps.setup

libhera = library_dependency("libhera")

URL = "https://bitbucket.org/grey_narn/hera.git"
SRC = "src/hera"
LIB = "usr/lib"
SUFF = is_apple() ? "dylib" : "so"
INC = ["/usr/local/include/boost","$SRC/geom_bottleneck/include"]
CMD = if is_apple()
    [`g++ -std=c++11 -c src/hera.cpp -I$(INC[1]) -I$(INC[2]) -o $LIB/hera.o`,
        `g++ -static-libstdc++ -dynamiclib -fPIC -I$(INC[1]) -I$(INC[2]) -o $LIB/libhera.$SUFF $LIB/hera.o`]
else
    [`gcc -std=c++11 -c -fPIC -I$(INC[1]) -I$(INC[2]) src/hera.cpp -o $LIB/hera.o`,
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
