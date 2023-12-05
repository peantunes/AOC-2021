import Foundation

func day3() -> Result {
    let content = "input-day3.txt".openFile
    let lines = content.split(separator: "\n").compactMap(String.init).map { Array.init($0).map { String($0) } }

    return Result(day: 3,
                  numberOfLines: lines.count,
                  solution1: { lines.submarineConsumption },
                  solution2: {
                    let oxygen = OxygenLevel.oxygenRating(array: lines)
                    let co2 = OxygenLevel.co2Rating(array: lines)
                    return oxygen * co2
                  })
}

private enum OxygenLevel {
    static let numberOfDigits = 12

    static func oxygenRating(array: [[String]]) -> Int {
        getResult(array: array, columnIndex: 0, condition: { $0 >= $1 })
    }

    static func co2Rating(array: [[String]]) -> Int {
        getResult(array: array, columnIndex: 0, condition: { $0 < $1 })
    }

    static private func filteredResults(array: [[String]], columnIndex: Int, condition: (Double, Double) -> Bool) -> [[String]] {
        let filtered1 = array.filter({ $0[columnIndex] == "1" })
        if condition(Double(filtered1.count), Double(array.count)/2.0) {
            return filtered1
        } else {
            return array.filter({ $0[columnIndex] == "0" })
        }
    }

    static private func getResult(array: [[String]], columnIndex: Int, condition: @escaping (Double, Double) -> Bool) -> Int {
        let filteredResults = filteredResults(array: array, columnIndex: columnIndex, condition: condition)
        if filteredResults.count <= 1 || columnIndex >= numberOfDigits-1 {
            return filteredResults.first!.joined().binaryToInt()
        } else {
            return getResult(array: filteredResults, columnIndex: columnIndex + 1, condition: condition)
        }
    }
}

private extension Array where Element == [String] {

    var submarineConsumption: Int {
        var columns: [Int] = Array<Int>(repeating: 0, count: OxygenLevel.numberOfDigits)
        for row in self {
            for index in 0..<row.count {
                let char = row[index]
                columns[index] += char == "0" ? -1 : 1
            }
        }
        var gameRate: Int = 0
        var epsilonRate: Int = 0
        var tempRate: String = ""
        var tempEpsil: String = ""
        for index in 0..<columns.count {
            let column = columns[index]
            let value = 2.pow(toPower: OxygenLevel.numberOfDigits-1-index)
            if column > 0 {
                tempRate += "1"
                tempEpsil += "0"
                gameRate += value
            } else {
                tempRate += "0"
                tempEpsil += "1"
                epsilonRate += value
            }
        }
//        print("Forward: \(columns)")
//        print("game rate: \(gameRate) - \(tempRate) - \(Int(strtoul(tempRate, nil, 2)))")
//        print("epsilon rate: \(epsilonRate) - \(tempEpsil) - \(Int(strtoul(tempEpsil, nil, 2)))")
        return gameRate*epsilonRate
    }
}

private extension String {
    func binaryToInt() -> Int {
        Int(strtoul(self, nil, 2))
    }
}

extension Int {
    func pow(toPower: Int) -> Int {
        guard toPower > 0 else { return toPower == 0 ? 1 : 0 }
        return Array(repeating: self, count: toPower).reduce(1, *)
    }
}
