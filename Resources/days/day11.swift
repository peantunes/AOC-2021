import Foundation

func day11() -> Result {
    let values = "input-day11.txt".openFile.split(separator: "\n").map { $0.compactMap { Int(String($0)) } }

    return Result(day: 11,
                  numberOfLines: values.count,
                  solution1: { solution1(values: values, cycles: 100) },
                  solution2: { solution1(values: values, cycles: 1000) })
}

private struct Point: Hashable, Equatable {
    let x: Int
    let y: Int
}

private func solution1(values: [[Int]], cycles: Int = 100) -> Int {
    var flashes = 0
    var local = values
    for c in 0..<cycles {
        var flashed: [Point] = []
//        print("cycle \(c)")
        loopXY(values: local) { x, y in
            guard !flashed.contains(Point(x: x, y: y)) else {
                return
            }
            let value = local[y][x] + 1
            if value <= 9 {
                local[y][x] = value
            } else {
                local[y][x] = 0
                flashed.append(Point(x: x, y: y))
                flashes += flash(octopus: &local, x: x, y: y, flashed: &flashed)
            }
        }
        if local.allSatisfy({ $0.allSatisfy { $0 == 0 } }) {
            print("all flashed: \(c)")
            return c + 1
        }
//        print(local.map({$0.map(String.init).joined()}).joined(separator: "\n"))
    }
    return flashes
}

//1 - 35
//2 - 45 = 80

private func flash(octopus: inout [[Int]], x: Int, y: Int, flashed: inout [Point]) -> Int {
    var flashes = 1
    let x1 = x == 0 ? 0 : x-1
    let x2 = x+1 > octopus[0].count-1 ? octopus[0].count-1 : x+1
    let y1 = y == 0 ? 0 : y-1
    let y2 = y+1 > octopus.count-1 ? octopus.count-1 : y+1
    for xA in x1...x2 {
        for yA in y1...y2 {
            guard !flashed.contains(Point(x: xA, y: yA)) else {
                continue
            }
            let value = octopus[yA][xA] + 1
            if value <= 9 {
                octopus[yA][xA] = value
            } else {
                octopus[yA][xA] = 0
                if (yA != y || xA != x) {
                    flashed.append(Point(x: xA, y: yA))
                    flashes += flash(octopus: &octopus, x: xA, y: yA, flashed: &flashed)
                }
            }
        }
    }
    return flashes
}

private func loopXY(values: [[Int]], block: (Int, Int) -> Void) {
    for y in 0..<values.count {
        let row = values[y]
        for x in 0..<row.count {
            block(x, y)
        }
    }
}
