//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day6() {
        let start = Date()
        print("*** Starting day 6 ***")
        let content = "2022/2022-day6.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(findStart(lines: lines))")
        print("result 2: \(findStart(lines: lines, numberOfChars: 14))")
        print("*** ending day 6 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func findStart(lines: [String], numberOfChars: Int = 4) -> Int {
        for line in lines {
            guard !line.isEmpty else { break }
//            print(line)
            let current = Array(line)
            var acumulator: [Character] = []
            for (index, c) in current.enumerated() {
                if let startIndex = acumulator.firstIndex(of: c) {
                    if startIndex + 1 < acumulator.count {
                        acumulator = Array(acumulator[startIndex+1..<acumulator.count])
                    } else {
                        acumulator = []
                    }
                }
                acumulator.append(c)
//                print(acumulator)
                if acumulator.count == numberOfChars {
                    return index + 1
                }
            }
        }
        return 0
    }
}
