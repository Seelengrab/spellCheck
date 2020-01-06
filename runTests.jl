using spellTests

function runTests()
    println("Running spell-testset1.txt")
    @time spelltest(testset(readlines(open("spell-testset1.txt"))))
    println("Running spell-testset2.txt")
    @time spelltest(testset(readlines(open("spell-testset2.txt"))))
end

isinteractive() || runTests() 