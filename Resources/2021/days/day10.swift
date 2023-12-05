import Foundation

func day10() -> Result {
    let values = "input-day10.txt".openFile.split(separator: "\n").map(String.init)

    return Result(day: 10,
                  numberOfLines: values.count,
                  solution1: { solution1(values: values) },
                  solution2: { solution2(values: values) })
}

private func solution2(values: [String]) -> Int {
    var answers = [Int]()
    for line in values {
        if let result = validateLine2(line: line) {
            answers.append(result)
        }
    }
    return answers.sorted()[answers.count/2]
}

private func validateLine2(line: String) -> Int? {
    let openChunks = ["(","[","{","<"]
    let closeChunks = [")","]","}",">"]
    let points = [1, 2, 3, 4]
    var pile = [String]()
    for item in line {
        let stringItem = String(item)
        if openChunks.contains(stringItem) {
            pile.append(String(stringItem))
        } else {
            if pile.count > 0,
               let closeIndex = closeChunks.firstIndex(of: String(stringItem)),
               let openIndex = openChunks.firstIndex(of: pile.last!),
               closeIndex == openIndex {
                pile.removeLast()
            } else if pile.count > 0 {
                return nil
            }
        }
    }

    if pile.count > 0 {
        var sum = 0
        for open in pile.reversed() {

            let openIndex = openChunks.firstIndex(of: open)!
            sum *= 5
            sum += points[openChunks.distance(from: openChunks.startIndex, to: openIndex)]

        }
        return sum
    }
    return nil
}

private func solution1(values: [String]) -> Int {
    var count = 0
    for line in values {
        count += validateLine(line: line)
    }
    return count
}

private func validateLine(line: String) -> Int {
    let openChunks = "([{<"
    let closeChunks = ")]}>"
    let points = [3, 57, 1197, 25137]
    var pile = [Character]()
    for item in line {
        if openChunks.contains(item) {
            pile.append(item)
        } else {
            if pile.count > 0,
               let closeIndex = closeChunks.firstIndex(of: item),
               let openIndex = openChunks.firstIndex(of: pile.last!),
               closeIndex == openIndex {
                pile.removeLast()
            } else {
                return points[closeChunks.distance(from: closeChunks.startIndex, to: closeChunks.firstIndex(of: item)!)]
            }
        }
    }
    return 0
}
