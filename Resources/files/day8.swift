import Foundation

func day8() {
    let start = Date()
    print("*** Starting day 8 ***")
    let values = "input-day8.txt".openFile.split(separator: "\n").map(String.init)
    print("number of lines: \(values.count)")
    print("result 1: \(solution1(values: values))")
    print("result 2: \(solution2(values: values))")
    print("*** ending day 8 ***", start.timeIntervalSinceNow)
    print("\n")
}

private func solution1(values: [String]) -> Int {
    var count = 0
    for value in values {
        let content = value.split(separator: "|").map(String.init)
        let output = content[1].trimmingCharacters(in: .whitespaces).split(separator: " ")
        for outputItem in output {
            count += [2, 3, 4, 7].contains(outputItem.count) ? 1 : 0
        }
    }
    return count
}

private func solution2(values: [String]) -> Int {
    var total = 0
    for value in values {
        let content = value.split(separator: "|").map(String.init)
        let input = content[0].trimmingCharacters(in: .whitespaces).split(separator: " ").map(String.init)
        let elements = identifyElements(sequence: input)

        let output = content[1].trimmingCharacters(in: .whitespaces).split(separator: " ").map(String.init)
        var currentNumber = ""

        for outputItem in output {
            let current = String(outputItem.sorted())
            guard let found = elements.first(where: { $0.key == current })?.value else {
                continue
            }

            currentNumber = "\(currentNumber)\(found)"

        }
//        print(currentNumber)
        total += Int(currentNumber) ?? 0
    }
    return total
}

private func identifyElements(sequence: [String]) -> [(key: String, value: String)] {
    var elements = [String: String]()
    for element in sequence.sorted(by: { $0.count < $1.count }) {
        switch element.count {
        case 2:
            elements["1"] = String(element.sorted())
        case 3:
            elements["7"] = String(element.sorted())
        case 4:
            elements["4"] = String(element.sorted())
        case 5: // 2 3 5
            let temp = String(element.sorted())
            if let element1 = elements["1"],
               temp.filter({ element1.sorted().contains($0) }).count == 2 { // validates against 1
                elements["3"] = temp
            } else if let element1 = elements["1"],
                      let element4 = elements["4"]?.removeFrom(element1),
                      temp.filter({ element4.sorted().contains($0) }).count == 2 { // validates against 4
                elements["5"] = temp
            } else {
                elements["2"] = temp
            }
        case 6: // 0 9 6
            let temp = String(element.sorted())
            if let element1 = elements["1"],
               temp.filter({ element1.sorted().contains($0) }).count < 2 {
                elements["6"] = temp
            } else if let element4 = elements["4"],
               temp.filter({ element4.sorted().contains($0) }).count == 4 {
                elements["9"] = temp
            } else {
                elements["0"] = temp
            }
        case 7:
            elements["8"] = String(element.sorted())
        default:
            continue
        }
    }
    return elements.map { (key: $0.value, value: $0.key) }
}

private extension String {
    func removeFrom(_ string: String) -> String {
        filter { !string.contains($0) }
    }
}

