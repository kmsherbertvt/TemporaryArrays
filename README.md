# TemporaryArrays

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://kmsherbertvt.github.io/TemporaryArrays.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://kmsherbertvt.github.io/TemporaryArrays.jl/dev/)
[![Build Status](https://github.com/kmsherbertvt/TemporaryArrays.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/kmsherbertvt/TemporaryArrays.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/kmsherbertvt/TemporaryArrays.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/kmsherbertvt/TemporaryArrays.jl)

This package provides the macro `@temparray`,
    which allocates an array, for temporary use in a local scope.

Subsequent calls with the same signature
    (e.g. from the same line of code repeated in a loop)
    will be allocated the *same* array, without any extra allocations.

The point is to be able to use "work variables"
    that persist and get re-used throughout a computation,
    but in a julianic and readable way.

In order for this to be worthy of the Julia registry:
- Figure out how to get this to work across multiple threads.

  Does `Memoization.jl` use the same cache for all threads? I don't know.
  If not, there's nothing to do.
  If it does, our macro should insert another symbol into the `index`,
    unique to the thread.
  Or, if that unavoidably incurs some allocation,
    I would be content to simply include an example in the README.
