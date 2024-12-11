using TemporaryArrays
using Test

module Module_1
    module Submodule
        import ...@temparray
        A = @temparray(ComplexF32, (1,2,3), :hygiene)
    end
end

module Module_2
    module Submodule
        import ...@temparray
        A = @temparray(ComplexF32, (1,2,3), :hygiene)
    end
end


@testset "TemporaryArrays.jl" begin
    # INTERFACE CHECKS
    #= Verify that the macro produces the output the interface claims. =#
    A = @temparray(Float64, (3,4))
    @test eltype(A) == Float64
    @test size(A) == (3,4)

    # HYGIENE CHECKS
    #= Verify that arrays produced with identical args are identical. =#
    B = @temparray(Float64, (3,4), :withsymbol)
    C = @temparray(Float64, (3,4), :withsymbol)
    @test A !== B
    @test B === C
    #= Verify that arrays produced with identical args,
        but in different modules, are distinct.

    Note this is true even if the basename of the module matches. =#
    @test Module_1.Submodule.A !== Module_2.Submodule.A

    # ALLOCATION CHECKS
    #= Verify that the macro call with literal args truly eliminates allocations. =#
    @temparray(Int, (500,500), :a, :whole, :lotta, :bytes)
    timed = @timed @temparray(Int, (500,500), :a, :whole, :lotta, :bytes)
    @test timed.bytes == 0
end
