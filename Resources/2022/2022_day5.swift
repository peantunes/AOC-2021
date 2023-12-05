//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day5() {
        let start = Date()
        print("*** Starting day 5 ***")
        let content = "2022/2022-day5.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(readStacks(lines: lines))")
        print("result 2: \(readStacks2(lines: lines))")
        print("*** ending day 5 ***", start.timeIntervalSinceNow)
        print("\n")
    }
//    [D]
//[N] [C]
//[Z] [M] [P]
// 1   2   3
    
    private func readStacks(lines: [String]) -> String {
        var lastIndex = 0
        var stacks = [[Character]](Array(repeating: [Character](), count: 10))
        for (index, line) in lines.enumerated() {
            lastIndex = index
            guard !line.isEmpty else { break }
            let current = Array(line)
            var i = 0
            for j in stride(from: 0, to: line.count-1, by: 4) {
                if current[j] == "[" {
                    stacks[i].append(current[j+1])
                }
                i += 1
            }
        }
        
        for index in lastIndex+1..<lines.count {
            let line = lines[index]
            guard !line.isEmpty else { break }
            let action = line.split(separator: " ") //move 1 from 2 to 1
            let howMany = Int(action[1])!
            let from = Int(action[3])! - 1
            let to = Int(action[5])! - 1
            
            for _ in 1...howMany {
                let this = stacks[from].removeFirst()
                stacks[to].insert(this, at: 0)
//                print(stacks)
            }
        }
        var phrase = ""
        for i in 0..<10 {
            guard let char = stacks[i].first.map(String.init) else { continue }
            phrase += char
        }
        return phrase
    }
    
    private func readStacks2(lines: [String]) -> String {
        var lastIndex = 0
        var stacks = [[Character]](Array(repeating: [Character](), count: 10))
        for (index, line) in lines.enumerated() {
            lastIndex = index
            guard !line.isEmpty else { break }
            let current = Array(line)
            var i = 0
            for j in stride(from: 0, to: line.count-1, by: 4) {
                if current[j] == "[" {
                    stacks[i].append(current[j+1])
                }
                i += 1
            }
        }
        
        for index in lastIndex+1..<lines.count {
            let line = lines[index]
            guard !line.isEmpty else { break }
            let action = line.split(separator: " ") //move 1 from 2 to 1
            let howMany = Int(action[1])!
            let from = Int(action[3])! - 1
            let to = Int(action[5])! - 1
            var temp: [Character] = []
            for _ in 1...howMany {
                temp.append(stacks[from].removeFirst())
            }
            stacks[to].insert(contentsOf: temp, at: 0)
        }
        var phrase = ""
        for i in 0..<10 {
            guard let char = stacks[i].first.map(String.init) else { continue }
            phrase += char
        }
        return phrase
    }
}
