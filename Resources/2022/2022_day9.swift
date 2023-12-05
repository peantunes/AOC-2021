//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day9() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 9 ***")
        let content = "2022/2022-day9.txt".openFile
        let lines = content.split(separator: "\n").map(String.init)
        print("number of Lines: \(lines.count)")
//        print("result 1: \(tailsCount(lines: lines, tails: 2))")
        print("result 2: \(tailsCount(lines: lines, tails: 10))")
        print("*** ending day 9 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func tailsCount(lines: [String], tails: Int) -> Int {
        let X = 0
        let Y = 1
        var visited = Set<[Int]>(arrayLiteral: [0,0])
        var tail: [[Int]] = Array(repeating: [0,0], count: tails)
        for line in lines {
            let movement = line.split(separator: " ")
            let direction = movement[0]
            let steps = Int(String(movement[1]))!
            var change = [0,0]
            var vector = X
            switch direction {
            case "U":
                vector = Y
                change = [0, -1]
            case "D":
                vector = Y
                change = [0, 1]
            case "R":
                vector = X
                change = [1, 0]
            case "L":
                vector = X
                change = [-1, 0]
            default:
                fatalError("should not be here")
            }
            
            let vectorChange = change[vector]
            for _ in 1...steps {
                let oldTail = tail
                tail[0][vector] += vectorChange
                for t in 1..<tails {
                    guard tail[t-1] != oldTail[t-1] else {
                        continue
                    }
                    let previous = tail[t-1]
                    let deltaX = tail[t][X] - previous[X]
                    let deltaY = tail[t][Y] - previous[Y]
                    if abs(deltaX) > 1 {
                        tail[t][X] += (deltaX > 0 ? -1 : 1)
                        tail[t][Y] = previous[Y]
                    } else if abs(deltaY) > 1 {
                        tail[t][Y] += (deltaY > 0 ? -1 : 1)
                        if tail[t][Y] != previous[Y] {
                            tail[t][X] = previous[X]
                        }
                    }
                    if abs(deltaX) > 2 || abs(deltaY) > 2 {
                        print(line)
                        print(deltaX, deltaY)
                        print("old", oldTail)
                        print("current", tail)
                    }
                    if t >= 9 {
//                        print(tail[t])
                    }
                }
                visited.insert(tail[tails-1])
//                print(tail, visited.count)
            }
            
        }
        return visited.count
    }


}
