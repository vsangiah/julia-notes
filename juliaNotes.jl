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

# Numeric datatypes: Real -> Integer and AbstractFloat
# integer N bits range - -2^N to 2^N-1
# get how many bits are there in your machine: 
Sys.WORD_SIZE
# Sys has lot of methods check it out

# to get the maximum and minimum value of each data type
typemax(Int8)
typemin(Int64)
# Try 
typemax(Int64) + 1
typemax(Int128) * 2

# For very large numbers:
big(10)^50

typemax(Float64)
# The scientific E notation works only as a means to convey Float64 numbers, Replace E with f, you get Float32
y = 2.4565E-4; # e or E is allowed in this scientific notation of floating point numbers=
typeof(y)
# gives Float64

z = 4.55f4 # Only f and NOT F
typeof(z)
# gives Float32

# For float16 numbers, you need to explicitly specify Float16(NN)
a = Float16(10.35445) # gives Float16(10.35445) as ans

# Type - downcasting and upcasting is possible in Julia. 
x = 100 # Int64
y = Int8(x);
# successful downcast: y is Int8
z = Int32(y)
# successful upcast: z is Int32
a = UInt32(-z) # will error out with truncation error at -1


# Crossing between datatypes has some caveats
x=10.33435
y = Int8(x); # Error case

x= 10
y=Float32(x); # Successful


# To reperesent millions, lakhs, crores without needing a comma
x = 10_00_000; # same as 1000000


# INFINITIES - a number that is greater than all floating point values
x = Inf # or Inf64 by default
y = Inf16
z = -Inf32
sizeof(x) # gives 8Bytes corresponding to 64 bits
typeof(x) # gives Float64
typeof(y) # gives Float16
sizeof(y) # gives 2Bytes
typeof(z) # gives Float32
sizeof(z) # gives 4Bytes

# Divde by zeros:
x = 1/0 # gives Inf (positive Float64 infinity) 
y = -1/0 # gives -Inf
x2 = typemax(Float64) # gives Inf
z = 0/0 # gives NaN - not a floating point number but it is Float64 datatype!
typeof(z) # Float64
# Alternate way to get NaN
a = 0*Inf
b = Inf - Inf

# TIP: Incorporate asserting for NaNs and Infs in your code using isnan and isinf
isinf(x) # true
 m = typemax(Float64);
 isinf(m) # true
isnan(z) # true

# Machine Epsilon
eps() # gives minimum possible number that could be represented after a given number 
eps(Float32) # gives minimum possible representation of number in Float32

# strangely, eps increases with the number that is passed through. The max is with 0.0
eps(0.0) # gives 5E-324
eps(1) # gives error, you need to pass float
eps(1.0) # gives 2.22E-16
eps(10.0) # gives 1.7E-15
# 10.0 + ANY_NUMBER_BELOW_EPS10 will give 10.0
# 10.0 + ANY_NUMBER_ABOVE_EPS10 will give 10.0000000that_number
10.0 + 2E-15 # gives 10.000000000000002
10.0 + 1E-18 # gives 10.0
eps(100000.0) # gives 1.4E-11

#PRO TIP: Functions whos return values are normalised to this range [-1,1] are rich with information. 
# because there is finer representation of the numbers close to 0. This is a good practice.
# Fun question: how many real numbers can we represent between [0,1] using your home computer?

# True false boolean types: 8bit representation
x = true;
typeof(x) # gives Bool
sizeof(x) # 1

# alternate ways:
y = Bool(1) # true; in Julia, only 1(Int) or 1.0(Float) is allowed as arg (BUT it could be any non zero integer in MATLAB)
z = Bool(0.0) # false; arg should be zero 0(Int) or 0.0(Float)


# COMPARISONS: (new)
1 == 1.0 # true
Int8(1.0) == Float32(1.0) # true
Float64(1.0) == Float32(1.0) # true
10.3E0 == 10.3f0 # false ?? didnt expect
3.14E2 == Float16(3.14E2) # true ?? didnt expect
3.1433E2 == Float16(3.1433E2) # false ?? didnt expect
Float64(10.3E-2)==Float16(10.3E-2) # false ?? didnt expect
10.3 == Float16(10.3) # false ?? didnt expect

Inf==Inf #true
Inf16==Inf32 # true ?? didnt expect
NaN==NaN # true
NaN==NaN32 # false ?? didnt expect
# There is an automatic upcast happeing when two different byte sized numbers are operated upon
1+1.0 # gives Float64 2.0
Float16(1.0) + Float32(1.0) # gives Float32 2.0f0
Inf32 + Inf # gives Inf (Inf64)
NaN32 + NaN16 # gives NaN32

# TIP: Dont use different byte sized numbers in your code. Stay safe guys! This is nasty when it comes to comparison related logics.

# Rational number:
x = 10//3
typeof(x) # Rational{Int64}
sizeof(x) # 16 Bytes ie 2 Int64
y = 10.0//3.0 # Errors


# Complex numbers:
im # gives im which is square root of (-1). 
#Try 
sqrt(-1) # and it will throw error. MATLAB automatically calculates it as 'i'
sqrt(im^2) # gives im. 
# Function overloading mishap maybe!

sizeof(im) # is two ?? didnt expect
typeof(im) # Complex{Bool}
1 + 3im # gives the same 
1+3 im # gives parse error, dont leave space
typeof(1+3im) # Complex{Int64}
sizeof(1+3im) # gives 16 Bytes ie 2 Int64
sizeof(0.0+1.0im) # is 16Bytes ie 2 Float64
typeof(10.0+3.0im) # Complex{Float64}

im*im #or im^2 gives -1+0im Complex{Int64}

# Here too, automatic upcast happens:
 Float32(10.0)+ Float16(3.0)im  # gives 10.0f0 + 3.0f0im Complex{Float32}

complex(1,1) # gives 1 + 1im
complex(im) # gives im Bool
complex(1.0im) # gives 0.0+1.0im
real(10.0+3.0im) # gives 10.0
imag(10.0+3.0im) # gives 3.0
conj(10.0+3.0im) # gives 10.0-3.0im

# Use these for asserting datatype checks
isa(10.0, Float64) #true
isa(10//3, Rational{Int64}) # true
isa(im, Complex{Int64}) # false because it is independently a bool
isa(10.0 + 3.0im, Complex)
isa(10.0+ 3.0im, Complex{Float64})
