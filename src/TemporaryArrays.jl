module TemporaryArrays
    export @temparray

    import Memoization: @memoize

    """
        @temparray(F, shape, index...)

    Allocate an array, for temporary use in a local scope.

    Subsequent calls with the same signature
        (e.g. from the same line of code repeated in a loop)
        will be allocated the *same* array, without any extra allocations.

    The point is to be able to use "work variables"
        that persist and get re-used throughout a computation,
        but in a julianic and readable way.

    Of course, if that array is still being used by the previous call, chaos ensues.
    This macro will automatically insert an additional index unique to the calling module
        to prevent unintended collisions.
    Nevertheless, you should be careful to always use a different `index`
        when requesting multiple arrays of the same type and shape
        from within the same module.
    Most importantly, do not EVER let the arrays escape their local scope,
        i.e. never return them in a function call.

    # Parameters
    - F::Type{<:Number} - a concrete number type (e.g. `Float64`)
    - shape::Tuple{Int} - the shape of the array
    - index::Any - a unique identifier, to prevent unwanted collisions

        @doctest```
        a1 = @temparray(Float64, (3,4), :same)
        a2 = @temparray(Float64, (3,4), :same)
        a3 = @temparray(Float64, (3,4), :different)

        @assert eltype(a1) == Float64
        @assert shape(a1) == (3,4)
        @assert a1 === a2
        @assert a1 !== a3
        ```

    """
    macro temparray(F, shape, index...)
        modulename = Symbol(__module__)
        return Expr(:call, :_allocate,
            esc(:($F)),
            esc(:($shape)),
            :($(QuoteNode(modulename)), $(index...)),
        )
    end

    @memoize Dict function _allocate(::Type{<:F}, shape, index) where {F}
        return Array{F}(undef, shape)
    end

end
