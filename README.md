# The Timings

A julia implementation of the spellchecker introduced by norvig, [here](https://norvig.com/spell-correct.html). 

I've coded this up years ago, but couldn't get the exact numbers correct (I count one 'the' too many, among other things) and thus never bothered testing the speed. That is, until dunefox on the julialang discourse made me remember and check my solution.

Here are the timings of this thing I get on my machine (produced by running `julia runTests.jl`):

```
Running spell-testset1.txt
74.4% of 270 correct (5.56% unknown) at 40.5 words per second        
  7.415867 seconds (59.03 M allocations: 3.677 GiB, 2.79% gc time)   
Running spell-testset2.txt
67.2% of 400 correct (10.8% unknown) at 43.9 words per second        
  9.109207 seconds (93.48 M allocations: 6.078 GiB, 3.25% gc time)  
```

And this is the machine this is run on:

```
julia> versioninfo()
Julia Version 1.3.0
Commit 46ce4d7933* (2019-11-26 06:09 UTC)
Platform Info:
  OS: Linux (x86_64-linux-gnu)
  CPU: Intel(R) Core(TM) i7-6600U CPU @ 2.60GHz
  WORD_SIZE: 64    
  LIBM: libopenlibm
  LLVM: libLLVM-6.0.1 (ORCJIT, skylake)
Environment:
  JULIA_NUM_THREADS = 4
```

That being said, there's still a bunch of time left on the table somewhere. I'm sure there's a way to reduce those allocations and get the speed up higher.

# What can be lerned from this?

Not much, except that a (almost) one to one translation from norvig's original version is algorithmically only okayish. If we wouldn't recreate all those intermediaries, we'd be in a much better place. This is basically a direct translation of the original python code, so there's no magic speedup to be found here. Since `edits1` and `edits2` recreate everything from scratch every time they're called, the run time is just `O(big)`. If you want to see a fast version in action, check [this one](https://github.com/Arkoniak/NorvigsTrieSpellchecker.jl) out. It's very different algorithmically and is absolutely not what norvig originally intended with his challenge to himself, but it's an interesting case study nonetheless.