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

# Type Backspace to exit to Julia original REPL


#=
Julia is a dynamically typed language - allows to optionally specify data types
There are builtin types, user defined types, parameterized types
=#

#=
Variable has the address to the location of the memory
=#

x=44;
typeof(x);
str = "any string";
ch='A'

# in VSCode, write some line in editor and type Shift+Enter to evaluate inline and display output there

#=
HOW to use different unicode representation of variables than alphanumeric variables?
 \alpha + TAB to get greek letter alpha
 \beta +  TAB  + \_u + TAB to get greek letter with underscore
 Use this rarely. because it is hard to retype and use elsewhere. use descriptive names like you used to with MATLAB or C++
=#

## Made a mistake with Julia constants?
# \pi = 40 # not allowed after showing up first as actual pi value
# BUT \pi=10 is accepted when you begin julia with this. you can revert this by 
# \pi = Base.\pi

# Single line comment
#=
Multi
line
comment
=#

# Multiple variable assignment
a,b,c = 4, "hi", 3.4
 
#= Explicit data type setting
 Useful in 3 ways:
Multiple dispatch
Human readability
Catch errors : how? - ANY_EXPRESSION::DataType will assert if the evaluated expression is not of the datatype
=#
x::Int64 = 1
y::String
z::Bool = true

# TIP: Dont change the variable datatypes often, you'll lose performance

# CONSTANTS:
const MYCONST = 10.3;
# try to change MYCONST - you'll get WARNING message and not error! There will be successful redefintion
# if a variable, say x is already defined in REPL
# you cannot do const x = 10; IT will error out saying constant is already defined.


# Types hierarchy : Starts with Any and branches out into subtypes - Refer a chart to understand
# There are abstact types that will help in the type definitions:
abstract type TYPE_NAME end
abstract type TYPE_NAME <: SUPER_TYPE end

subtypes(Any) # lists 500 of them, Number being one of them

supertype(AbstractFloat) 
#= 
Real
=#


subtypes(AbstractFloat)
#=
4-element Vector{Any}:
 BigFloat
 Float16
 Float32
 Float64
=#

subtypes(Number)
#=
3-element Vector{Any}:
 Base.MultiplicativeInverses.MultiplicativeInverse
 Complex
 Real
=#

subtypes(Complex) # Concrete data type
#=
Type[]
=#

subtypes(Real)
#=
4-element Vector{Any}:
 AbstractFloat
 AbstractIrrational
 Integer
 Rational
=#

subtypes(Integer)
#=
3-element Vector{Any}:
 Bool
 Signed
 Unsigned
=#

subtypes(Signed)
#=
6-element Vector{Any}:
 BigInt
 Int128
 Int16
 Int32
 Int64
 Int8
=#

subtypes(Int8) # Concrete data type
#=
Type[]
=#

#=
 Any thing other than Concrete Types are called Abstarct Types. With Abstract Types, we cannot create variables with it, We can only create variables with concrete data types. With abstract types, we can define function returntypes and function arguments.
=#

# U can define abstract types on your own
abstract type TYPE_NAME end
# or
abstract type TYPE_NAME <: SUPER_TYPE_NAME end

# U can assert based on supertypes:
Complex <: Number # true
Complex <: Integer # false
Int64 <: Signed # true






