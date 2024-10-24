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
abstract type TYPE_NAME{T<:ABSTRACT_TYPE} end # for structs (later..)

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


# Chars and strings
# There is AbstractChar (has only Char - '<single character>'), AbractString (has String, SubString, SubstitutionString)
ch = 'A';
char(ch); # Char
sizeof(ch) # gives 4Bytes same as Int32
num = Int32(ch); # you can typecast
#special unicode characters
ch1 = '\u03A3';
ch2 = '\u03B1';


str1 = "hellow";
typeof(str1); # gives String

# MULTILINE STRING
str2 = """ this
is 
a
multiline
string""";

# Get the characters using indices of string.
# INDICES start with 1 like MATLAB
ch11 = str1[2]; # gives char (unlike C++ which starts with 0)
ch12 = str[4];
ch13 = str[begin+3];
ch14 = str[end-1];

# Get Substrings
sst1 = str1[2:4]; # gives substring
sst1 = str1[end-3:end];

# get properties of string
firstindex(str1) # 1
lastindex(str1) # length of str1 - NOT ALWAYS
length(str1) # length of str1

str2 = "\alpha \beta \infty A "; #not all unicode characters are saved with single character's space
str2[2] #will error out
str[3] # will be space
# here lastindex(str2)  will not match length(str)


# Concatenation
str1*" "*str2 # gives str1 sopace and 
str1^4 # repeat the string 4 times

#Inline expression evaluation with strings
x=10
y=16.4f0
str3 = "$str1 is the first string and $str2 is the second. $x and $y adds up to $(x+y)"


# Define your own singleton primitive datatype: using "primitive type"
# primitive type <name of datatype> <number of bits (multiples of 8 to comply with rules of LLVM)> end
# primitive type <name of datatype> <: <name of super type> <number of bits> end
primitive type j505j 8 end

# Composite types: structs, records or objects 
# In Julia we cannot have member functions ( but only member variables) for these
# Julia functions have multiple dispatch

struct Cylinder
 height::Float64
 radius::Float64
end

filednames(Cylinder) # gives names of the fields only and not the datatype
Cylinder.types # gives svec(Float64, Float64)

C1 = Cylinder(10.43,2.47);
C1.height
C1.radius
fieldnames(C1) # errors unlike MATLAB classes
fieldnames(typeof(C1)) # gives result
C2(10) # errors
C3=Cylinder(10,34,667) # errors

# structures once instantiated, they are immutable
C1.height=329 # gives error, saying it cannot be changed

# inorder to be flexible use mutable struct during definittion

mutable struct circle
 radius::Float64
end

# If we dont specify datatype for the members, it will default to Any - not good for production sw
# struct itself comes with a data type Any if we dont specify - again not good for production (cosmetic impact only)

supertype(circle) # gives Any
supertype(Cylinder) # gives Any
abstract type SolidShapes end;
mutable struct Sphere <: SolidShapes
 radius::Float64
end
supertype(Sphere) # gives SolidShapes

# There is another way to group data types and use it to assert types UNIONS of abstract types
myIntStrType = Union{Integer,AbstractString};
x=10;
y="str";
z='c';
w=12.3;
x::myIntStrType # gives same as x
y::myIntStrType # gives same as y because x and y are Integer or String 
z::myIntStrType # gives error assert
w::myIntStrType # gives error assert


# Parametric types:
struct ParamCircle{AnyT}
 radius::AnyT
end
x = ParamCircle{Int64}(2) # succeeds creating circle x with storage of int64
y = ParamCircle{Int64}(2.4) # errors
z = ParamCircle{Float32}(22.2f0) # succeeds

typeof(x) # gives ParamCircle{Int64}
typeof(z) # gives ParamCircle{Float32}

x = ParamCircle(2) # succeeds creating circle x with storage of int64 automatically picks types
z = ParamCircle(22.2f0) # succeedscreating circle y with storage of Float32 automatically picks types

# enforce condition on parametric type
struct Rectangle{T <: Real}
 x::T
 y::T
end
r = Rectangle("d","4") # errors
r1 = Rectangle(1,23) # succeeds with creation of Int64 type
r2 = Rectangle(1,.33)  # errors as different datatypes will be needed

struct Rectangle{T1 <: Real, T2 <: Real}
 x::T1
 y::T2
end
r2 = Rectangle(1,.33) # will succeed with storing different datatypes for each






# Operations:
# special ones:
# \div+TAB gives division symbol: and it is used to do integer divisions
    # otherwise this integer division is accessed by div()
# \ - inverse division (x\y = y/x)
# ^ - power
# % - remainder
   # otherwise access by rem()

# tips
x=10;
y=44;
3x  # same as 3*x
2(x+4y) # same as 2*(x+4y)

# weird ways
+(10y,3x) # same as 10y+3x

# Comparisons
<= # \leq+TAB
>= # \geq+TAB
==
>
<
!= # \neq+TAB

# short way to check if in a range of values
x=10;
y=12;
z=15;
x<y<z # returns true as it does this: x<y && y<z

# ISAPPROX
# 0.4 + 0.2 = 0.6000000000000001 in machine
isequal(0.4+0.2, 0.6) # returns false due to floating point error
isapprox(0.4+0.2,0.6, atol=0.0001) # returns true
isapprox(0.4+0.2,0.6, atol=1e-20) # returns false
# \approx + TAB to get symbol to do same work

# DEEPCOPY and equivalence
x=[10,12];
y=x; # normal copy
z=deepcopy(x); # creates another memory location
x==y # true
x==z # true
x===y # true
x===z # false because the location of storage of z is different from x
#\equiv+TAB is same as ===



# Boolean operations (nearly same as MATLAB)
!
&&
||
# bitwise operators
~
&
|
#\xor+TAB
#\nanad+TAB
#\nor+TAB
>>> # logical shift right
>> # arithmetic shift right
<< # arithmetic shift left


# To see Bit representation of numbers, ] add Bits package and > using Bits command 
using Bits
bits(4)

# Short hand notations:
x=10
y=3

x-=3
y+=40
x^=3

# logarithms
#\euler+TAB
# ℯ = exp(1)
log(ℯ) # gives 1
log10(1000) # gives 3, same as log(10, 1000)
log2(8) # gives 3, smae as log(2, 8)

# Rounding off
round(103.33) # rounds to nearest integer 103.0 
ceil(222.4) # 223.0
floor(246.3) # 246.0 # NOTE it's float64
 
# absloute value and sign fcn
sign(-103.3) # -1.0
sign(0.0)  # 0.0
sign(0) # 0
sign(10) # 1

# Random numbers
rand(4) # gives 4 Float64 numbers
rand(Int64, 10);
rand(Int64,(5,3)); # random matrix


# Data Structures

# TUPLES
# Immutable Finite sequence or ordered list of numbers or, more generally, mathematical objects (not needed to be same time)

tpl1= (10, "Julia", 1.7)
tpl2 = tuple(1010, "Juliana", "3545.4") # NOTE: tuple -> function, Tuple -> DataType
tpl3 = 10, 2.34, "hii"

# named tuple: if you decide - go with only named tuple or dont name them at all
tpl4 = (name="abc", class="X",age = 15.32);
tpl4.name
tpl4.class
typeof(tpl4) # gives @NamedTuple{name::String, class::String, age::Float64}

# using tuple elements to assign variables
x,y,z = tpl4

# single element tuple
x = (2) # just an Int64 and not a tuple
tpl1 = (1.434, ) # leave a comma  after the first element

supertype(Tuple) # gives Any
typeof(tpl) # gives Tuple{Int64, String, Float64}


# Tuples are immutable - the comparisons happen with === and bit level comparisons take place, where it is stored
tpl1 = (1,"hellow",24.5)
tpl2 = (1,"hellow",24.5)
tpl1 === tpl2 # gives true

# Acces tuple elements
tp1[3]
tp2[2:3]

# Try to change values inside tuple - it will error out
tpl1[1] = "zsdfgbf" # error
# NTUPLE
# all elements same type tuple
t = (1,5,3,76,9,4) # typeof(t) : gives NTuple{6, Int64}

# defining ntuple with logic: arrayfun MATLAB equivalent but only MATLAB's 1:N can be utilised
ntuple(x-> x^3, 5) # (1, 8, 27, 64, 125)

# IN and NOTIN functions - equivalent to MATLAB contains but reversed arg order
in(1,t) # true because 1 is in t
#\in+TAB  ∈
#\notin+TAB ∉
1 ∈ t # same as before, returns true
200 ∉ t # returns false because 200 does not belong in t

# Dictionaries DICT() - KEY VALUE PAIRS - mutable
d1 = Dict()
d1 = Dict([("day",2),("week",23),("year",1993)])
d2 = Dict("day"=>31 ,"week"=>2, "year"=>1994);
d1["abc"] =23243243; # works as this is mutable
length(d1) # gives 3
d1.keys # produces junk also
d1.vals # produces junk also
# use this instead
keys(d1) # gives a ValueIterator
values(d1)

# out of bounds key will error out - key not found
d1["rfghfgsgszfgb"]
"agasagagrgarfgag" ∈ keys(d1) # gives false as keys(d1) is a ValueIterator
haskey(d1, "abc")
# get fcn: with an assert message if not found
get(d1, "abc", "NOT_FOUND_MSG") # returns 2
get(d1, "argfgbgfbhsfhfgarfg", "the element is not found da") # reurns the NOT_FOUND_MSG



# Merging 2 dictionaries
d = merge(d1,d2) # if keys are identical, replacement happens the last one in the arg list takes precedence
# merge with any function name that operates on the values
d33 = mergewith(*,d1,d2) # Dict{String, Int64} with 3 entries:  "day"  => 62  "year" => 3974042  "week" => 46


# Ranges and arrays:
# Ranges derived from: Any -> AbstractVector -> AbstractRange -> OrdinalRange -> AbstractUnitRange and StepRange
x=1:10
y=2:2:100
z=102.4:-2.35:34.54
typeof(z) # StepRangeLen{Float64, Base.TwicePrecision{Float64}, Base.TwicePrecision{Float64}, Int64}
typeof(x) # UnitRange{Int64}
superType(UnitRange) # AbstractUnitRange{T} where T<:Real
sizeof(x) # 16 Bytes ??
sizeof(y) # 24 Bytes ?? stores just the 3 integers mentioned in the ranges
sizeof(z) # 48 Bytes due to storing 4 numbers within it

# convert range to vector array
v = collect(z); # 29-element Vector{Floa t64}
sizeof(z) # 29 Float64 = 232

# TIP: using ranges saves the dynamic memory during the execution of programs

# range creation:
range(start = 2.3, step = 0.232, stop = 344.2) # Float64 step range
range(start = 2, stop = 33, length=32) # Gives a Float64 step range as opposed to Int64 because a division was involved
range(start = 2, step = 33, length=32) # Gives Int54 step range
LinRange(2,3,100) # Float64 LinRange



# Julia Array need not be homogeneous like C, FORTRAN or MATLAB
# ANY type array
arrANY = [232,35434.3434, 'r', "egdfzdgfhg"] # Vector{Any}

aFloat = [343.3454,654.456,46567.53] # Vector{Float64}
aInt = [343,464,8,92345] # Vector{Int64}
aStr = ["dfg";"rg";"rgterg"] # Vector{String}
aMix = [aFloat, aInt, aStr] # Vector{Vector}
isa(aMix,Vector{Vector}) # true

aInt[3:-1:1] 

aInt2 = [343,464,8,92345] # same content as aInt1
aInt1 == aInt2 # true
aInt1 === aInt2 # false because they are mutable and stored in differnt locations

length(aInt) # 4
aInt[5] = 10 # Bounds Error

# Playing with array mutability: adding and removing elements of array
append!(aInt,[22,455,678])
push!(aInt,6662) # dont push an array (push whatever T is: Vector{T} )
deleteat!(aInt,3) # third array index will be deleted
deleteat!(aInt,[1,2,3]) # delete the first second and third element
deleteat!(aInt, [2,4,3,3]) # will not work if indices are sorted(ascending) and unique
insert!(aInt,3, 343425246) # args: array, index to insert at, number to insert
pop!(aInt) # displays and removes the last element
popfirst!(aInt) # displays and removes the first element (there is no poplast)
# contd.
typeof(aInt) # Vector{Int64}
aInt[2] = 545.54 # Errors upcast is not possible
aInt[3:4] = [Uint8(2), Int32(-33)] 
typeof(aInt[3]) # gives Int64 - meaning that aInt remains with original datatype

			
# Contains (using in or \in+TAB) / subarrays (using SUBSET) comparison
343 ∈ aInt # true
in(2,aInt) # true
issubset([8,92345], aInt2) # true
 [8,92345] ∈ aInt2 # false BUT using correct symbol or function will do: 
# \subseteq+TAB - ⊆ or issubset
# \subsetneq+TAB - ⊊ or !issubset
# \supseteq+TAB - ⊇ or contains
# \supsetneq+TAB - ⊋ or ! contains
[8,92345] ⊆ aInt2 # true
[222,343,464,8,92345,333] ⊇ aInt2 # true

# eltype, length, 
eltype(aStr) # String
eltype(aInt) # Int64
length(aInt2) # 4


## Vectors and matrices
cv1 = [1,2,3,4] # Vector{Int64}
rv = [1 2 3 4 5;] # Matrix{Int64}
rvSF = [1 2 3 4] # Segmentaion fault ?? Didnt expect this
cv2 = [1;2;3;4] # Vector{Int64}
m = [1 2 3; 1 4 5; 2 3 1] # Matrix{Int64}
m2 = [ 1 2 3
	2 3 4
	3 4 5] # Matrix{Int64}
m3err = [1,2,3;2,3,4] # error: unexpected semicolon

# sizes and lengths
size(m2) # (3,3)
size(m,1) # 3
size(m,2) # 3
length(m) # 9

# accessing matrices:
m[2,3] # 5
m[end,end-1] # 3
m[8] # 3
m[100] # Segmentation fault on accessing out of bounds values

m[1,:] # 1 2 3 Vector{Int64}

# Concatenations:
rv1 = [1 2 3 4 5;]
rv2 = [6 7 8 9 10;]
rv3 = [11 12 13 14 15;]
hcat(rv1,rv2,rv3) # row vector Matrix{Int64}
vcat(rv1,rv2,rv3) # matrix Matrix{Int64}
cv1 = [1, 2, 3, 4, 5]
cv2 = [6, 7, 8, 9, 10]
cv3 = [11, 12, 13, 14, 15]
hcat(cv1,cv2,cv3) # matrix Matrix{Int64}
vcat(cv1,cv2,cv3) # column vector Vector{Int64}

x1 = [cv1,cv2]  # Avoid this: Vector{Vector{Int64}}
x2 = [rv1,rv2] # Avoid this: Vector{Matrix{Int64})
y = [cv1;cv2]  # Vector{Int64} of 2xsize cv1 + size cv2
z = [rv1; rv2] # Matrix{Int64} 2xsizerv1
a = [rv1 rv2] # row vector Matirx{Int64}
bSF = [cv1 cv2] # SegmenationFault
b = [cv1 cv2;] # Matrix{Int64} 


# Undefined matrix definition:
m = Matrix(undef, 3,3) # a 3x3 Matrix{Any} has undef in all 3x3 elements # may be avoid this Any for performant code?
# or 
m = Matrix{Any}(undef, 3,4) 

mf64 = Matrix{Float64}(undef,4,5); # 0.0 in all 4x5 elements

mixM = Matrix{Union{Int64,String}}(undef, 4,5) # has undef in all 4x5 elements

mf64[1:3,1:3] = 10.33; # segmentation fault
mf64[1,3] = 10; # will be typecasted to 10.0 F64
mf64[1,4] = 10.33;
mf64[1,5] = "s" # segmentation fault
mf64[1,5] = 's' # ASCII unicode number 50 will be typecasted to 50.0 F64

mi64 = Matrix{Int64}(undef, 4,5)
mi64[1,2] = 19;
mi64[1,4] = 10.33 # segmentation fault


# 'nothing' and 'missing'
ntng = nothing;
typeof(ntng) # Nothing
sizeof(ntng) # 0 Bytes

msng = missing;
typeof(msng) # Missing
sizeof(msng) # 0 Bytes

m_ntng = Matrix{Any}(nothing, 3, 5) # size 3*4*0
m_msng = Matrix{Any}(missing, 3, 5) # size 3*4*0


# If you want to reuse the above missing and nothing matrices
m_ntng(1,2) = 10.33 # but this is ANy Matrix

# Proper sematics would be this:
m1 = Matrix{Union{Int64,Nothing}} (nothing, 3,3); # size 3*3*8 - 8 comes from Int64

# Reshaping matrices
x=1:24;
reshape(x,3,8)
reshape(x,4) # segmentation fault
# there s no function that is haveing a ! for reshape

# Usual arrays, by default Float64:
zeros(10,3) # Matrix{Float64}
ones(2,4) # Matrix{Float64}
# we can specify the datatype
zeros(Int32, 11,3) # Matrix{Int32}
ones(UInt8, 10,10) # Matrix{UInt8}

# slightly unusual arrays
trues(10,3) # BitMatrix
falses(12,3) # BitMatrix


# Vector forms
trues(11) # BitVector
falses(12) # BitVector
ones(Int8, 12) # Vector{Int8}
zeros(Float32, 12) # Vector{Float32}


# Using fill and rand to manipulate the initialization
x = fill(19, 4,5) # Fills Int64(19) on every 4x5 element
y = fill(10.33, 4,5) # Fills Float64{10.33} on every element
r = rand(1:100, 4,5) # fills random Int64 values

# similar function to get a representative of the given matrix
xsim = similar(x) # gives a randomly generated values of same Matrix{Int64} 4x5
ysim_7_8 = similar(y, 7,8) # gives randomly generated values of same Matrix{Float64} but 7x8 dimension


# Multidimenional arrays

# example for 3d arrays:
rows = 4
cols = 5
layers = 3 

M3d = Matrix{UInt8}(undef, rows, cols, layers)

