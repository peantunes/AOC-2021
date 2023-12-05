//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day4() {
        let start = Date()
        print("*** Starting day 4 ***")
        let content = "2022/2022-day4.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(fullyContains(lines: lines))")
        print("result 2: \(overlaps(lines: lines))")
        print("*** ending day 4 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func fullyContains(lines: [String]) -> Int {
        var counter = 0
        for line in lines {
            guard !line.isEmpty else { break }
            let groups = line.split(separator: ",")
            let firstPair = groups[0].split(separator: "-").map(String.init).compactMap(Int.init)
            let lastPair = groups[1].split(separator: "-").map(String.init).compactMap(Int.init)
            if (firstPair[0] >= lastPair[0] && firstPair[1] <= lastPair[1])
                || (lastPair[0] >= firstPair[0] && lastPair[1] <= firstPair[1]) {
                counter += 1
            }
        }
        return counter
    }
    
    private func overlaps(lines: [String]) -> Int {
        var counter = 0
        for line in lines {
            guard !line.isEmpty else { break }
            let groups = line.split(separator: ",")
            let firstPair = groups[0].split(separator: "-").map(String.init).compactMap(Int.init)
            let lastPair = groups[1].split(separator: "-").map(String.init).compactMap(Int.init)
            if (firstPair[0] >= lastPair[0] && firstPair[0] <= lastPair[1])
                || (firstPair[1] >= lastPair[0] && firstPair[1] <= lastPair[1])
                || (lastPair[0] >= firstPair[0] && lastPair[0] <= firstPair[1])
                || (lastPair[1] >= firstPair[0] && lastPair[1] <= firstPair[1]) {
                counter += 1
            }
        }
        return counter
    }
}
