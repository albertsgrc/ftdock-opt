module.exports = @

getScores = (s) ->
    Number line.split(/\s+/)[3] for line in s.split('\n') when /^.?G_DATA/.test line

@eq = (a, b) ->
    [ scoresA, scoresB ] = [a, b].map getScores

    if scoresA.length isnt scoresB.length
        return { equal: no, message: 'Different number of scores' }

    maxDiff = 0

    for value, i in scoresA
        diff = Math.abs scoresA[i] - scoresB[i]

        maxDiff = diff if maxDiff < diff

        if diff > 2
            return { equal: no, message: "Score difference > 2 (#{diff})"}

    { equal: yes, message: "Max diff: #{maxDiff}" }
