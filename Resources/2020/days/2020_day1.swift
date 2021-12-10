import Foundation

struct AdventOfCode2020 { }

extension AdventOfCode2020 {
    func day1() {
        let start = Date()
        print("*** Starting day 1 ***")
        let content = "2020/2020-day1.txt".openFile
        let lines = content.split(separator: "\n").compactMap { Int($0) }
        print("number of Lines: \(lines.count)")
        print("result 1: \(sum2020(values: lines))")
        print("result 2: \(sum2020With3(values: lines))")
        print("*** ending day 1 ***", start.timeIntervalSinceNow)
        print("\n")
    }

    private func sum2020(values: [Int]) -> Int {
        for c1 in 0..<values.count {
            guard c1 + 1 < values.count else { return 0 }
            for c2 in (c1+1)..<values.count {
                if values[c1] + values[c2] == 2020 {
                    return values[c1] * values[c2]
                }
            }
        }
        return 0
    }

    private func sum2020With3(values: [Int]) -> Int {
        for c1 in 0..<values.count {
            guard c1 + 1 < values.count else { return 0 }
            for c2 in (c1+1)..<values.count {
                guard values[c1] + values[c2] < 2020 &&
                    c1 + 1 < values.count else { continue }
                for c3 in (c2+1)..<values.count {
                    if values[c1] + values[c2] + values[c3] == 2020 {
//                        print(values[c1], values[c2], values[c3])
                        return values[c1] * values[c2] * values[c3]
                    }
                }
            }
        }
        return 0
    }
}
