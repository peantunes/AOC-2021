import Foundation

func day9() -> Result {
    let values = "input-day9.txt".openFile.split(separator: "\n").map { $0.compactMap { Int(String($0)) } }

    return Result(day: 9,
                  numberOfLines: values.count,
                  solution1: { solution1(values: values) },
                  solution2: { solution2(values: values) })
}

private func solution1(values: [[Int]]) -> Int {
    var lowPoints = [Int]()
    for x in 0..<values.count {
        for y in 0..<values[x].count {
            if let current = lowPoint(values: values, x: x, y: y) {
                lowPoints.append(current)
            }
        }
    }
    return lowPoints.reduce(0, +)
}

private struct Point: Hashable {
    let x: Int
    let y: Int
}

private func solution2(values: [[Int]]) -> Int {
    var basins = [Int]()
    for x in 0..<values.count {
        for y in 0..<values[x].count {
            if lowPoint(values: values, x: x, y: y) != nil {
                basins.append(Set(findBasins(values: values, x: x, y: y)).count)
            }
        }
    }
//    print(basins)
    return basins.sorted().reversed().prefix(3).reduce(1, *)
}

private func findBasins(values: [[Int]], x: Int, y: Int) -> [Point] {
    let current = values[x][y]
    var basins = [Point(x: x, y: y)]
    if let up = values[safe: x]?[safe: y-1],
       up < 9,
       up > current {
        basins.append(contentsOf: findBasins(values: values, x: x, y: y-1))
    }
    if let down = values[safe: x]?[safe: y+1],
        down < 9,
        down > current {
         basins.append(contentsOf: findBasins(values: values, x: x, y: y+1))
    }
    if let left = values[safe: x-1]?[safe: y],
        left < 9,
        left > current {
         basins.append(contentsOf: findBasins(values: values, x: x-1, y: y))
    }
    if let right = values[safe: x+1]?[safe: y],
        right < 9,
        right > current {
         basins.append(contentsOf: findBasins(values: values, x: x+1, y: y))
    }
    return basins
}

private func lowPoint(values: [[Int]], x: Int, y: Int) -> Int? {
    let up = values[safe: x]?[safe: y-1] ?? -1
    let down = values[safe: x]?[safe: y+1] ?? -1
    let left = values[safe: x-1]?[safe: y] ?? -1
    let right = values[safe: x+1]?[safe: y] ?? -1
    let current = values[x][y]
    let elements = Array(arrayLiteral: up, down, left, right, current).filter({$0 >= 0}).sorted()
    if (elements[0] == current && elements[1] > current) {
        return current
    } else {
        return nil
    }
}

extension Array {

    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}

/*
 2199943210
 3987894921
 9856789892
 8767896789
 9899965678
 */
