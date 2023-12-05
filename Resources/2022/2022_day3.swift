//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day3() {
        let start = Date()
        print("*** Starting day 3 ***")
        let content = "2022/2022-day3.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(itemsSameBoth(values: lines))")
        print("result 2: \(similarItems3Rows(lines: lines))")
        print("*** ending day 3 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func itemsSameBoth(values: [String]) -> Int {
        var az = "abcdefghijklmnopqrstuvwxyz"
        az = az + az.uppercased()
        var itemsFound = [Character: Int]()
        for line in values {
            guard !line.isEmpty else { break }
            let middleIndex = line.index(line.startIndex, offsetBy: line.count / 2)
            let first = Set(line[line.startIndex..<middleIndex])
            let last = Set(line[middleIndex...])
            
            let result = first.intersection(last)
            result.forEach { c in
                let total = itemsFound[c] ?? 0
                itemsFound[c] = total + 1
            }
        }
        var points = 0
        for (key, qtd) in itemsFound {
            points += (az.distance(from: az.startIndex, to: az.firstIndex(of: key)!) + 1) * qtd
        }
        return points
    }
    
    private func similarItems3Rows(lines: [String]) -> Int {
        var az = "abcdefghijklmnopqrstuvwxyz"
        az = az + az.uppercased()
        let lastIndex = lines.count - 1
        var itemsFound = [Character: Int]()
        for i in stride(from: 0, through: lines.count-1, by: 3) {
            guard i + 3 <= lastIndex else { break }
            let line1 = Set(lines[i])
            let line2 = Set(lines[i+1])
            let line3 = Set(lines[i+2])
            
            let result = line1.intersection(line2).intersection(line3)
            result.forEach { c in
                let total = itemsFound[c] ?? 0
                itemsFound[c] = total + 1
            }
        }
//        print(itemsFound)
        
        var points = 0
        for (key, qtd) in itemsFound {
            points += (az.distance(from: az.startIndex, to: az.firstIndex(of: key)!) + 1) * qtd
        }
        return points
    }
}
