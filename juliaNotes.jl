#=
Julia is a Just In Time (JIT) compiled language (not interpreteted)
ie. the Julia code gets converted to machine code for execution on CPU runtime
Compilation methodology is built on top of LLVM compiler infra structure, that provides compilation strategy for static and dynamic compilation of programming languages.

www.llvm.org

Machine code is generated with the JIT compilation that works with LLVM and generates LLVM code. Then it is optimised to native code. So the first time run is always slow. The subsequent runs are fast.

Julia has joined Petaflop club like the C, C++, FORTRAN

Julia HUB - Rich package eco system: juliahub.com/ui/packages 
(Look for MPI package)

After Julia installs, REPL (Read Evaluate Print Loop) interactive command prompt is available for prototyping. To get there: Terminal -> $ julia
=#


# Type ? in REPL: help?> prompt opens
Array

# Type ; in REPL: terminal shell prompt will open
pwd

# Type ] in REPL: package manager prompt is opened
status
st
update
up
add LinearAlgebra
remove LinearAlgebra



 





