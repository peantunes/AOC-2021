import Foundation

private var guides = [String: [String]]()

func day21() -> Result {
    
    return Result(day: 21,
                  numberOfLines: 2,
                  solution1: { solution1(p1: 8, p2: 2) },
                  // 4 8 test // 8 2 final
                  solution2: { solution2(positions: [8, 2]) })
}

private struct Position: Hashable, Equatable {
    let length: Int
    let score: Int
}
private let possibilities = [3: 1,
                             4: 3,
                             5: 6,
                             6: 7,
                             7: 6,
                             8: 3,
                             9: 1]

private func movePlayer(position: Int, score: Int, steps: Int) -> Position {
    let position_final = ((position + steps - 1) % 10) + 1
    return Position(length: position_final, score: score + position_final)
}

private func roll_next(position: Int, score: Int, lenght: Int, p: Double, dict: inout [Position: Double]) {
    
    for (roll_sum, total) in possibilities {
        guard score < 21 else {
            return
        }
        let new_position = movePlayer(position: position, score: score, steps: roll_sum)
        let new_lenght = lenght + 1
        let p_new = p * Double(total)
        let position_s = Position(length: new_lenght, score: new_position.score)
        dict[position_s] = (dict[position_s] ?? 0.0) + p_new
        roll_next(position: new_position.length, score: new_position.score, lenght: new_lenght, p: p_new, dict: &dict)
    }
}

private func solution2(positions: [Int]) -> Int {
    var mainPositions: [[Position: Double]] = []
    for position in positions {
        var d = [Position: Double]()
        roll_next(position: position, score: 0, lenght: 0, p: 1.0, dict: &d)
        mainPositions.append(d)
    }
    
    var won = [0.0, 0.0]
    for (position1, value1) in mainPositions[0] {
        for (position2, value2) in mainPositions[1] {
            if position1.score >= 21 && position2.length == position1.length - 1 && position2.score < 21 {
                won[0] += value1 * value2
            }
            if position2.score >= 21 && position2.length == position1.length && position1.score < 21 {
                won[1] += value1 * value2
            }
        }
    }
    return Int(won.max()!)
}

private func solution1(p1: Int, p2: Int) -> Int {
    let turns = 10
    var dice = 0
    var diceTimes = 0
    var newP1 = p1
    var newP2 = p2
    var totalP1 = 0
    var totalP2 = 0
    
    while totalP1 < 1000 && totalP2 < 1000 {
        let rollP1 = nextDice(dice+1) + nextDice(dice+2) + nextDice(dice+3)
        let rollP2 = nextDice(dice+4) + nextDice(dice+5) + nextDice(dice+6)
        let p1Value = ((rollP1%turns + newP1)%turns)
        let p2Value = ((rollP2%turns + newP2)%turns)
        newP1 = p1Value == 0 ? 10 : p1Value
        newP2 = p2Value == 0 ? 10 : p2Value
        
        totalP1 += newP1
        if totalP1 >= 1000 {
            return (diceTimes+3) * totalP2
        }
        totalP2 += newP2
        if totalP2 >= 1000 {
            return (diceTimes+6) * totalP1
        }
        
        dice = nextDice(dice+6)
        diceTimes += 6
    }
    
    return 0
}

private func nextDice(_ value: Int) -> Int {
    (value > 100) ? (value%100) : value
}
