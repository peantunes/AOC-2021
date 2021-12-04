import Foundation

func day4() {
    let start = Date()
    print("*** Starting day 4 ***")
    let content = "input-day4.txt".openFile
    let lines = content.split(separator: "\n").compactMap(String.init)
    let bingo = Bingo(lines: lines)
    let winner = bingo.winner()
    let looser = bingo.looser()
    print("number of lines: \(lines.count)")
    print("result 1: \(winner.calculate(values: bingo.numbers))")
    print("result 2: \(looser.calculate(values: bingo.numbers))")
    print("*** ending day 4 ***", start.timeIntervalSinceNow)
    print("\n")
}

class Card {
    struct NumberInCard {
        let number: String
        var checked: Bool
        init(number: String) {
            self.number = number
            checked = false
        }
    }

    var numbers: [NumberInCard]
    var winAfter: Int = Int.max

    init(numbers: [String]) {
        self.numbers = numbers.map(NumberInCard.init(number:))
    }

    func draw(_ values: [String]) {
        for index in 0..<values.count {
            let value = values[index]
            guard let numberIndex = numbers.firstIndex(where: { $0.number == value }) else {
                continue
            }
            numbers[numberIndex].checked = true
            if isWinner {
                winAfter = index
//                print("card \(numbers.map(\.number)) is winner after \(index) with value: \(value)")
                return
            }
        }
    }

    func calculate(values: [String]) -> Int {
        let total = numbers.filter {!$0.checked}.reduce(0, { $0 + (Int($1.number) ?? 0) })
        let number = (Int(values[winAfter]) ?? 0)
//        print(total, number)
        return total * number
    }

    private var isWinner: Bool {
        for index in 0..<5 {
            // check lines
            if check(getIndex: { index*5 + $0 })
                //check row
                || check(getIndex: { $0*5 + index }) {
                return true
            }
        }
        return false
    }

    private func check(getIndex: (Int) -> Int) -> Bool {
        for index in 0..<5 {
            guard numbers[getIndex(index)].checked else {
                break
            }
            if index == 4 {
                return true
            }
        }
        return false
    }
}

class Bingo {

    let numbers: [String]
    var cards: [Card]

    init(lines: [String]) {
        numbers = lines.first!.split(separator: ",").compactMap(String.init)
        var cards: [Card] = []
        var tempCardNumbers: [String] = []
        for index in 1..<lines.count {
            let line = lines[index]
            if line.trimmingCharacters(in: .whitespaces).isEmpty {
                continue
            }
            tempCardNumbers.append(contentsOf: line.split(separator: " ").map(String.init))

            if tempCardNumbers.count == 25 {
                cards.append(Card(numbers: tempCardNumbers))
                tempCardNumbers = []
            }
        }

        self.cards = cards
        drawNumbers()
    }

    private func drawNumbers() {
        for card in cards {
            card.draw(numbers)
        }
    }

    func winner() -> Card {
        return cards.sorted(by: { $0.winAfter < $1.winAfter }).first!
    }
    func looser() -> Card {
        return cards.sorted(by: { $0.winAfter > $1.winAfter }).first!
    }
}
