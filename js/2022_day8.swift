//
//  main.swift
//  Treetop Tree House
//

import Foundation

enum Part {
    case One
    case Two
}

var startTime = Date().timeIntervalSinceReferenceDate

func getInput(year: Int, day: Int, file: String) -> [String] {
    let fileURL = URL(fileURLWithPath: "/Users/pedroan/Development/Pedro/AOC-2021/js/2022-day7.txt",
                      isDirectory: false,
                      relativeTo: FileManager.default.homeDirectoryForCurrentUser)
    guard let rawInput = try? String(contentsOf: fileURL) else {
        print("Could not open file \(fileURL.path)")
        exit(EXIT_FAILURE)
    }

    // Separate the input file into lines, make sure it has something in it
    let inputLines: [String] = rawInput.components(separatedBy: .newlines)
    guard inputLines.count > 0 else {
        print("Input file empty!")
        exit(EXIT_FAILURE)
    }
    return inputLines
}

var forest: [[Int]] = []
var visibility: [[Bool]] = []

func checkVisibility(_ trees: [[Int]], _ visible: inout [[Bool]]) {
    // look from top down
    var temp = forest
    visible[0] = Array(repeating: true, count: temp[0].count) // first row always visible
    for i in 1..<temp.count {
        for j in 0..<temp[i].count {
            if temp[i][j] > temp[i-1][j] {
                // visible
                visible[i][j] = true
            } else {
                // not visible, carry previous taller tree forward
                temp[i][j] = temp[i-1][j]
            }
        }
    }
}

extension Array where Self.Iterator.Element: RandomAccessCollection {
    func transposed() -> [[Self.Iterator.Element.Iterator.Element]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }
}

func run(on input: [String], part: Part) -> Int {
    var result = 0
    if part == .One {
        for line in input {
            var treeLine: [Int] = []
            for character in line {
                treeLine.append(character.hexDigitValue!)
            }
            forest.append(treeLine)
            visibility.append(Array(repeating: false, count: treeLine.count))
        }
        
        checkVisibility(forest, &visibility)   // top view
        forest = forest.reversed()
        visibility = visibility.reversed()
        checkVisibility(forest, &visibility )  // bottom view
        forest = forest.transposed()
        visibility = visibility.transposed()
        checkVisibility(forest, &visibility)  // left view
        forest = forest.reversed()
        visibility = visibility.reversed()
        checkVisibility(forest, &visibility )  // right view
        
        // count results
        for treeLine in visibility {
            result += treeLine.reduce(0) { $0 + ($1 ? 1 : 0) }
        }
    } else {
        for row in 1..<forest.count-1 {
            for col in 1..<forest[0].count-1 {
                var scenicScore = 1
                // look up
                var d = 0
                for y in stride(from: row-1, through: 0, by: -1) {
                    if forest[y][col] < forest[row][col] {
                        d += 1
                    } else {
                        d += 1
                        break
                    }
                }
                scenicScore *= d
                // look down
                d = 0
                for y in row+1..<forest.count {
                    if forest[y][col] < forest[row][col] {
                        d += 1
                    } else {
                        d += 1
                        break
                    }
                }
                scenicScore *= d
                // look left
                d = 0
                for y in stride(from: col-1, through: 0, by: -1) {
                    if forest[row][y] < forest[row][col] {
                        d += 1
                    } else {
                        d += 1
                        break
                    }
                }
                scenicScore *= d
                // look right
                d = 0
                for y in col+1..<forest[0].count {
                    if forest[row][y] < forest[row][col] {
                        d += 1
                    } else {
                        d += 1
                        break
                    }
                }
                scenicScore *= d
                result = max(result, scenicScore)
            }
        }
    }
    return result
}

let inputLines = getInput(year: 2022, day: 8, file: "input.txt")

let result1 = run(on: inputLines, part: .One)
print("Part 1: The answer is \(result1)")

let runTime1 = Date().timeIntervalSinceReferenceDate - startTime
print("Part 1 run time: \(runTime1) seconds\n")

startTime = Date().timeIntervalSinceReferenceDate
let result2 = run(on: inputLines, part: .Two)
print("Part 2: The answer is \(result2)")

let runTime2 = Date().timeIntervalSinceReferenceDate - startTime
print("Part 2 run time: \(runTime2) seconds\n")
