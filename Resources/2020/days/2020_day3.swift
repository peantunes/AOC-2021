import Foundation

extension AdventOfCode2020 {

    func day3() {
        let start = Date()
        print("*** Starting day 3 ***")
        let content = "2020/2020-day3.txt".openFile
        let lines = content.split(separator: "\n").compactMap(String.init).map(Array.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(countTrees(lines: lines))")
        print("result 2: \(withSlopes(lines: lines, slopes: [.init(down: 1, right: 1), .init(down: 1, right: 3), .init(down: 1, right: 5), .init(down: 1, right: 7), .init(down: 2, right: 1)]))")
        print("*** ending day 3 ***", start.timeIntervalSinceNow)
        print("\n")
    }

    private struct Slope {
        let down: Int
        let right: Int
    }

    //right 3 down 1

    private func countTrees(lines: [[String.Element]], down: Int = 1, right: Int = 3) -> Int {
        var x = 0
        var trees = 0
        let maxColumns = lines[0].count
        for y in stride(from: 0, through: lines.count-1, by: down) {
            let line = lines[y]
            let element = line[x%maxColumns]
            if element == "#" {
                trees += 1
            }
            x += right
        }
        return trees
    }

    private func withSlopes(lines: [[String.Element]], slopes: [Slope]) -> Int {
        var total = 1
        for slope in slopes {
            total *= countTrees(lines: lines, down: slope.down, right: slope.right)
        }
        return total
    }

}
