//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day8() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 8 ***")
        let content = "2022/2022-day8.txt".openFile
        let lines = content.split(separator: "\n").map { $0.compactMap { Int(String($0)) } }
        print("number of Lines: \(lines.count)")
        print("result 1: \(visibleFromOutside(lines: lines))")
        print("result 2: \(part2solution(lines: lines))")
        print("*** ending day 8 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func visibleFromOutside(lines: [[Int]]) -> Int {
        let height = lines.count
        let width = lines.first!.count
        var visibleElements = height*2 + (width-2)*2
        for x in 1..<(width-1) {
            for y in 1..<height-1 {
                var up = true, down = true, left = true, right = true
                var z = 0
                while z < x {
                    if (lines[z][y] >= lines[x][y]) {
                        up = false;
                        break;
                    }
                    z += 1
                }
                z = width - 1
                while z > x {
                    if (lines[z][y] >= lines[x][y]) {
                        down = false;
                        break;
                    }
                    z -= 1
                }
                z = 0
                while z < y {
                    if (lines[x][z] >= lines[x][y]) {
                        left = false;
                        break;
                    }
                    z += 1
                }
                z = height - 1
                while z > y {
                    if (lines[x][z] >= lines[x][y]) {
                        right = false;
                        break;
                    }
                    z -= 1
                }
                
                visibleElements += [up, down, left, right].contains(true) ? 1 : 0
            }
        }
        return visibleElements
    }
    
    private func part2solution(lines: [[Int]]) -> Int {
        let height = lines.count
        let width = lines.first!.count
        var part2 = 0
        for x in 1..<(width-1) {
            for y in 1..<height-1 {
                var up = 0, down = 0, left = 0, right = 0
                var z = 0
                while z < x {
                    up += 1
                    if (lines[z][y] >= lines[x][y]) {
                        break
                    }
                    z += 1
                }
                z = width - 1
                while z > x {
                    down += 1
                    if (lines[z][y] >= lines[x][y]) {
                        break
                    }
                    z -= 1
                }
                z = 0
                while z < y {
                    left += 1
                    if (lines[x][z] >= lines[x][y]) {
                        break
                    }
                    z += 1
                }
                z = height - 1
                while z > y {
                    right += 1
                    if (lines[x][z] >= lines[x][y]) {
                        break
                    }
                    z -= 1
                }
                part2 = max(part2, (up * down * left * right))
            }
        }
        return part2
    }
    
}
