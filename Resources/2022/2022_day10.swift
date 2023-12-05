//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day10() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 10 ***")
        let content = "2022/2022-day10.txt".openFile
        let lines = content.split(separator: "\n").map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(execution(lines: lines))")
        print("result 2: \(screen(lines: lines))")
        print("*** ending day 10 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func execution(lines: [String]) -> Int {
        var cycle = 1
        var register = 1
        var result = 0
        for line in lines {
            for i in 1...2 {
                if ([20, 60, 100, 140, 180, 220].contains(cycle))  {
//                    print(cycle, register, cycle * register)
                    result += cycle * register
                }
                if i == 2 && line != "noop" {
                    let value = Int(String(line.split(separator: " ").last!))!
                    register += value
                }
                
                cycle += 1
                if line == "noop" {
                    break
                }
            }
        }
        return result
    }

    private func screen(lines: [String]) -> Int {
        var cycle = 1
        var register = 1
        var result = 0
        var screenLine = ""
        let rowCycle = cycle%40
        let newChar = rowCycle >= register && rowCycle <= register+2 ? "#" : "."
        screenLine += newChar
        for line in lines {
            for i in 1...2 {
                if ([40, 80, 120, 160, 200, 240].contains(cycle))  {
//                    print(cycle, register, cycle * register)
                    result += cycle * register
                    print(screenLine)
                    screenLine = ""
                }
                if i == 2 && line != "noop" {
                    let value = Int(String(line.split(separator: " ").last!))!
                    register += value
                }
                
                cycle += 1
                
                let rowCycle = cycle%40
                let newChar = rowCycle >= register && rowCycle <= register+2 ? "#" : "."
                screenLine += newChar
                
                if line == "noop" {
                    break
                }
            }
        }
        return result
    }

}
