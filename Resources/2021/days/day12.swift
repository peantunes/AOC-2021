import Foundation

private var guides = [String: [String]]()

func day12() -> Result {
    let values = "input-day12.txt".openFile.split(separator: "\n").map(String.init).map { $0.split(separator: "-").map(String.init) }
    for row in values {
        if guides[row[0]] == nil {
            guides[row[0]] = []
        }
        if guides[row[1]] == nil {
            guides[row[1]] = []
        }
        guides[row[0]]?.append(row[1])
        guides[row[1]]?.append(row[0])
    }

    return Result(day: 12,
                  numberOfLines: values.count,
                  solution1: { countPaths(sequence: ["start"], repeat: false) },
                  solution2: { countPaths(sequence: ["start"], repeat: true) })
}

private func countPaths(sequence: [String], repeat: Bool = true) -> Int {
    guard let last = sequence.last,
          last != "end" else { return 1 }
    var paths = 0
    for next in guides[last] ?? [] {
        if !(next.lowercased() == next && sequence.contains(next)) {
            paths += countPaths(sequence: sequence + [next], repeat: `repeat`)
        } else if `repeat` && sequence.filter({$0 == next}).count == 1 && next != "start" {
            paths += countPaths(sequence: sequence + [next], repeat: false)
        }
    }
    return paths

}
