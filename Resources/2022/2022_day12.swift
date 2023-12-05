//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day12() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 12 ***")
        let content = "2022/2022-day12.txt".openFile
        let lines = content.split(separator: "\n").map { Array(String($0)) }
        print("number of Lines: \(lines.count)")
        print("result 1: \(solution1(chars: lines))")
//        print("result 2: \(tailsCount(lines: lines, tails: 10))")
        print("*** ending day 12 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    struct Position: Hashable {
        let x: Int
        let y: Int
    }
    
    private func solution1(chars: [[Character]]) -> Int {
        var Q: [(Position, Int, Character)] = []
        var visited = Set<Position>()
        for (indexY, line) in chars.enumerated() {
            for (indexX, char) in line.enumerated() {
                guard char == "S" else {
                    continue
                }
                let p = Position(x: indexX, y: indexY)
                Q.append((p, 0, "a"))
                visited.insert(p)
//                break
            }
        }
        
        func push(x: Int, y: Int, d: Int, a: Character) {
            guard x < chars[0].count && x >= 0 && y < chars.count && y >= 0 else {
                return
            }
            let p = Position(x: x, y: y)
            guard !visited.contains(p) else {
                return
            }
            var b = chars[y][x]
            if b == "E" {
                b = "z"
            }
            if b.asciiValue! > a.asciiValue! + 1 {
                return
            }
            visited.insert(p)
//            print(p, b, d+1)
            Q.append((p, d+1, b))
        }
        
        while let (p, d, a) = Q.popLast() {
            if chars[p.y][p.x] == "E" {
                return d
            }
            push(x: p.x + 1, y: p.y, d: d, a: a)
            push(x: p.x - 1, y: p.y, d: d, a: a)
            push(x: p.x, y: p.y + 1, d: d, a: a)
            push(x: p.x, y: p.y - 1, d: d, a: a)
        }
        
        return 0
    }
    
    
    private func findEnd(chars: [[Character]]) -> Int {
        let UP = 0, RIGHT = 1, DOWN = 2, LEFT = 3
        let alpha: [Character] = Array("abcdefghijklmnopqrstuvwxyzE")
        var stepped = [Position: Bool]()
        let maxX = chars.first?.count ?? 0
        let maxY = chars.count
        var current = Position(x: 0, y: 0)
        
        for (indexY, line) in chars.enumerated() {
            if let indexX = line.firstIndex(of: "S") {
                current = Position(x: indexX, y: indexY)
                break
            }
        }
        stepped[current] = true
        
        var bestResult = 1000000000
        
        func recursive(from: Position, value: Character, next: Character, stepped: [Position: Bool], level: Int = 1) -> Int? {
//            var localStepped = stepped
            guard level < 500 else {
                return nil
            }
            var nextSearchs = [Position]()
            print(from, value, next, level)
            // up
            if from.y > 0 {
                nextSearchs.append(Position(x: from.x, y: from.y - 1))
            }
            // right
            if from.x < maxX - 1 {
                nextSearchs.append(Position(x: from.x + 1, y: from.y))
            }
            // down
            if from.y < maxY - 1 {
                nextSearchs.append(Position(x: from.x, y: from.y + 1))
            }
            // left
            if from.x > 0 {
                nextSearchs.append(Position(x: from.x - 1, y: from.y))
            }
            for (index, search) in nextSearchs.enumerated() {
                let current = chars[search.y][search.x]
                if (current == value || current == next) && stepped[search] == nil {
                    
                    if current == "E" {
                        bestResult = min(bestResult, level - 1)
                        return 1
                    } else {
                        var newNext = next
                        if current != value,
                           let nextIndex = alpha.firstIndex(of: current)?.advanced(by: 1),
                           let newChar = alpha[safe: nextIndex] {
                            newNext = newChar
                        }
                        
                        var localStepped = stepped
                        localStepped[search] = true
                        if let result = recursive(from: search, value: current, next: newNext, stepped: localStepped, level: level + 1) {
                            return level
                        }
                    }
                    
                }
            }
            
            return nil
        }
        
        let result = recursive(from: current, value: alpha[0], next: alpha[1], stepped: stepped)
        return bestResult
    }
}
