//
//  day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 01/12/2021.
//

import Foundation


func day1() {
    let start = Date()
    print("*** Starting day 1 ***")
    let content = "input-day1.txt".openFile
    let lines = content.split(separator: "\n").compactMap { Int($0) }
    print("number of Lines: \(lines.count)")
    print("total greather than: \(lines.countGreaterThanMultiple())")
    print("total greather with 3 lines: \(lines.countGreaterThanMultiple(rows: 3)))")
    print("*** ending day 1 ***", start.timeIntervalSinceNow)
    print("\n")
}

private extension Array where Element == Int {

    func countGreaterThanMultiple(rows: Int = 1) -> Int {
        var previous: Int = sumNextAmount(index: 0, amount: rows)
        var count = 0

        for index in 1..<self.count {
            let lastPrevious = previous
            previous = sumNextAmount(index: index, amount: rows)
            if previous > lastPrevious {
                count += 1
            }
        }
        return count
    }

    private func sumNextAmount(index: Int, amount: Int) -> Int {
        var accumulator = 0
        for currentIndex in index..<(index+amount) {
            if currentIndex < count {
                accumulator += self[currentIndex]
            }
        }
        return accumulator
    }
}

