module spellTests

using Test, spellCheck

export test, spelltest, testset

function test()
    @testset begin
        @testset "constants & parsing" begin
            @test length(WORDS) == 32192
            @test sum(values(WORDS)) == 1115504
            @test sort(collect(WORDS), by = x -> x[2], rev=true)[1:10] == sort(collect(Dict(
                "the" => 79808,
                "of" => 40024,
                "and" => 38311,
                "to" => 28765,
                "in" => 22020,
                "a" => 21124,
                "that" => 12512,
                "he" => 12401,
                "was" => 11410,
                "it" => 10681)), by = x -> x[2], rev=true)
            @test WORDS["the"] == 79808
            @test WORDS["and"] == 38311
            @test WORDS["in"] == 22020
        end

        @testset "words" begin
            @test collect(words("This is a TEST.")) == ["this", "is", "a", "test"]
        end

        @testset "counter" begin
            @test collect(counter(words("This is a test. 123; A TEST this is."))) == collect(Dict("test"=> 2, "this"=> 2, "is"=> 2, "123"=> 1, "a"=> 2))
        end

        @testset "P" begin
            @test P("quintessential") == 0.
            @test 0.07 < P("the") < 0.08
        end

        @testset "correction" begin
            @test correction("speling") == "spelling"              # insert
            @test correction("korrectud") == "corrected"           # replace 2
            @test correction("bycycle") == "bicycle"               # replace
            @test correction("inconvient") == "inconvenient"       # insert 2
            @test correction("arrainged") == "arranged"            # delete
            @test correction("peotry") =="poetry"                  # transpose
            @test correction("peotryy") =="poetry"                 # transpose + delete
            @test correction("word") == "word"                     # known
            @test correction("quintessential") == "quintessential" # unknown
        end
    end
end

"""
Run correction(wrong) on all (right, wrong) pairs; report results.
"""
function spelltest(tests, verbose=false)
    start = time()
    good, unknown = 0, 0
    n = length(tests)
    for (right, wrong) in tests
        w = correction(wrong)
        good += (w == right)
        if w != right
            unknown += !(right in keys(WORDS))
            if verbose
                println("correction($wrong) => $(w) ($(WORDS[w])); expected $(right) ($(WORDS[right]))")
            end
        end
    end
    dt = time() - start
    println("$(round(100*(good / n), sigdigits=3))% of $n correct ($(round(100*(unknown / n), sigdigits=3))% unknown) at $(round((n / dt), sigdigits=3)) words per second")
end

"""
Parse 'right: wrong1 wrong2' lines into [("right", "wrong1"), ("right", "wrong2")] pairs.
"""
function testset(lines)
    return [(right, wrong) for (right, wrongs) in (split(line, ":") for line in lines) for wrong in split(wrongs)]
end


end
