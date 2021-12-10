import Foundation

func day5() {
    let start = Date()
    print("*** Starting day 5 ***")
    let content = "input-day5.txt".openFile
    let lines = content.split(separator: "\n").compactMap(String.init)
    let termals = Hydrotermals(lines: lines)
//    print(termals.coordinates.map(\.description))
    print("number of lines: \(lines.count)")
    print("result 1: \(termals.numberOfChangesa1())")
    print("result 2: \(termals.numberOfChangesa2())")
    print("*** ending day 5 ***", start.timeIntervalSinceNow)
    print("\n")
}

private class Hydrotermals {
    struct CoordinateChange: Equatable {
        struct Point: Equatable, Hashable {
            let x: Int
            let y: Int

            var description: String {
                "\(x),\(y)"
            }
        }
        let start: Point
        let end: Point

        var changes: [Point] {
            guard start.x == end.x || start.y == end.y else {
                return []
            }
            if start.x != end.x {
                let elements = start.x < end.x ? start.x...end.x : (end.x...start.x)
                return elements.map { .init(x: $0, y: start.y) }
            } else if start.y != end.y {
                let elements = start.y < end.y ? start.y...end.y : (end.y...start.y)
                return elements.map { .init(x: start.x, y: $0) }
            }
            return []
        }

        var changesWithDiagonal: [Point] {
            let yChange = abs(start.y - end.y)
            let xChange = abs(start.x - end.x)
            guard yChange > 0 && xChange > 0 && yChange == xChange else {
                return []
            }

            var points: [Point] = []
            let xWalk = start.x > end.x ? -1 : 1
            let yWalk = start.y > end.y ? -1 : 1
            for item in 0...xChange {
                points.append(Point(x: start.x + item*xWalk, y: start.y + item*yWalk))
            }

            return points
        }
    }

    let coordinates: [CoordinateChange]

    init(lines: [String]) {
        coordinates = lines.map { line in
            let values = line
                .replacingOccurrences(of: " -> ", with: "-")
                .split(separator: "-")
                .map(String.init)
            let positionChange = values.map { $0.split(separator: ",").compactMap( { Int($0) }) }
            return CoordinateChange(start: .init(x: positionChange[0][0], y: positionChange[0][1]), end: .init(x: positionChange[1][0], y: positionChange[1][1]))
        }
    }

    func numberOfChangesa1() -> Int {
        let changes = calculate(items: coordinates.map(\.changes))
        return changes.values.filter { $0 > 1 }.count
    }

    func numberOfChangesa2() -> Int {
        let changes = calculate(items: coordinates.map(\.changes) + coordinates.map(\.changesWithDiagonal))
        return changes.values.filter { $0 > 1 }.count
    }

    func printContent() {

    }

    private func calculate(items: [[CoordinateChange.Point]]) -> [CoordinateChange.Point: Int] {
        //.sorted(by: { $0.x < $1.x && $0.y < $1.y })
        var changes = [CoordinateChange.Point: Int]()
        items.forEach { coordinates in
            coordinates.forEach { coordinate in
                guard changes[coordinate] != nil else {
                    changes[coordinate] = 1
                    return
                }
                changes[coordinate]! += 1
            }
        }
        return changes
    }

}
