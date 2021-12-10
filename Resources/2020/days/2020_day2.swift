import Foundation

extension AdventOfCode2020 {

    func day2() {
        let start = Date()
        print("*** Starting day 2 ***")
        let content = "2020/2020-day2.txt".openFile
        let lines = content.split(separator: "\n").compactMap(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(checkValidPassword1(lines: lines))")
        print("result 2: \(checkValidPassword2(lines: lines))")
        print("*** ending day 2 ***", start.timeIntervalSinceNow)
        print("\n")
    }

    private struct Rule {
        let min: Int
        let max: Int
        let letter: Character
        let sentence: String

        init(string: String) {
            //1-3 a: abcde
            let items = string.split(separator: ":")
            let rule = items[0].split(separator: " ")
            let minMax = rule[0].split(separator: "-").map(String.init).compactMap(Int.init)
            let sentenceString = items[1].trimmingCharacters(in: .whitespaces)
            min = minMax[0]
            max = minMax[1]
            letter = Character(String(rule[1]))
            sentence = sentenceString
        }

        var isValid: Bool {
            let amount = sentence.filter { $0 == letter }.count
            return amount >= min && amount <= max
        }

        var validPositon: Bool {
            (Array(sentence)[min-1] == letter) ^^ (Array(sentence)[max-1] == letter)
        }
    }

    private func checkValidPassword1(lines: [String]) -> Int {
        lines.reduce(0) { valids, line in
            let rule = Rule(string: line)
            return valids + (rule.isValid ? 1 : 0)
        }
    }

    private func checkValidPassword2(lines: [String]) -> Int {
        lines.reduce(0) { valids, line in
            let rule = Rule(string: line)
            return valids + (rule.validPositon ? 1 : 0)
        }
    }

}

infix operator ^^
extension Bool {
    static func ^^(lhs:Bool, rhs:Bool) -> Bool {
        if (lhs && !rhs) || (!lhs && rhs) {
            return true
        }
        return false
    }
}
