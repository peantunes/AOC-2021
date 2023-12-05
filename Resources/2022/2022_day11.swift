//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day11() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 11 ***")
        let content = "2022/2022-day11.txt".openFile
        let lines = content.split(separator: "\n").map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(read(lines: lines))")
//        print("result 2: \(screen(lines: lines))")
        print("*** ending day 11 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private class Monkey {
        var items: [Int]
        var operation: (Int, Int) -> Int
        var divisible: Int
        var flow: (Int) -> Bool
        
        init(lines: [String]) {
            items = []
            operation = { a, b in a*b }
            divisible = 1
            flow = { return $0 == 1 }
        }
    }
    
    private func read(lines: [String]) -> Int {
        var old = 1
        var i = 0
        while true {
            var monkeyNumber = Int(String(lines[i].split(separator: " ")[0].split(separator: ":")[0]))
            var startingItems = lines[i+1].replacingOccurrences(of: " ", with: "").split(separator: ":")[1].split(separator: ",").compactMap { Int(String($0)) }
            var operationString = lines[i+2].replacingOccurrences(of: " ", with: "").split(separator: "=")[1]
            let operator1: Character
            let fun: (Int, Int) -> Int
            if operationString.contains("*") {
                operator1 = "*"
                fun = mult
            } else {
                operator1 = "+"
                fun = add
            }
            let values = operationString.split(separator: operator1)
            
            var first: Int = old
            let value = Int(String(values[1]))
            
            let divisible = Int(String(lines[i+3].split(separator: " ").last!))!
            
            for startingItem in startingItems {
                let operationResult: Int
                if let value {
                    operationResult = fun(startingItem, value)
                } else {
                    operationResult = fun(startingItem, startingItem)
                }
                if operationResult%divisible == 0 {
                    
                } else {
                    
                }
            }
        }
        return 0
    }
    
    private func add(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    
    private func mult(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
}
