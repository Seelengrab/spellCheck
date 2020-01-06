module spellCheck

export WORDS, counter, words, correction, P, custMax, edits1, edits2, known, splits

function counter(s)
    res = Dict{String, Int}()

    for word in s
        if haskey(res, word)
            res[word] = res[word] + 1
        else
            res[word] = 1
        end
    end

    res
end

function words(text)
    (x.match for x in eachmatch(r"\w+", lowercase(text)))
end

const WORDS = counter(words(read("big.txt", String)))

function P(word, N=sum(values(WORDS)))
    get(WORDS, word, 0.) / N
end

function custMax(words, f)
    g = ""
    for w in words
        g = (f(g) > f(w) ? g : w)
    end
    g
end

function correction(word)
    custMax(candidates(word), P)
end

function candidates(word)
    res = known([word])
    if res != []
        return res
    end

    res = known(edits1(word))
    if res != []
        return res
    end

    res = known(edits2(word))
    if res != []
        return res
    end

    return [word]
end

function known(words)
    [ w for w in words if w in keys(WORDS) ]
end

function edits1(word)
    letters    = "abcdefghijklmnopqrstuvxyz"
    splits     = [ ("", word) ] ∪ [ (word[1:i],word[i+1:end]) for i in 1:length(word) ]
    deletes    = [ "$L$(R[2:end])"                            for (L, R) in splits if R != "" ]
    transposes = [ "$L$(R[2])$(R[1])$(R[3:end])"              for (L, R) in splits if length(R) >  1]
    replaces   = [ "$L$c$(R[2:end])"                          for (L, R) in splits if R != "" for c in letters ]
    inserts    = [ "$L$c$R"                                   for (L, R) in splits for c in letters ]
    filter(x -> x != "", deletes ∪ transposes ∪ replaces ∪ inserts)
end

function edits2(word)
    (e2 for e1 in edits1(word) for e2 in edits1(e1))
end

end
