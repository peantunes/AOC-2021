//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day13() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 13 ***")
        let content = "2022/2022-day13.txt".openFile
        let lines = content.split(separator: "\n").map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(load(lines: lines))")
//        print("result 2: \(screen(lines: lines))")
        print("*** ending day 13 ***", start.timeIntervalSinceNow)
        print("\n")
    }
}

private extension AdventOfCode2022 {
    func load(lines: [String]) {
        
    }
    func arrayRead(line: String) {
        let comp = Array(line)
        var content: [Any] = []
        var bracketLevel = 0
        for i in 0..<comp.count {
            let c = comp[i]
            if c == "[" {
                
            } else if c == "]" {
                bracketLevel -= 1
            }
            
        }
    }
}
