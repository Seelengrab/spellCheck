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
