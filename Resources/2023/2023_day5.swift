//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2023 {
    func day5() {
        let start = Date()
        print("*** Starting day 5 ***")
        let content = "2023/2023-day5.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        exe1(values: lines)
//        print("result 1: \(rockPaperScissors2(values: lines))")
        print("*** ending day 5 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private func exe1(values: [String]) {
        var seeds: [Double] = []
        var seeds2: [(s: )] = []
        var tempSeeds = seeds2
        var area = "<none>"
        var inMap = false
        var seedsIndexMoved: [Int] = []
        for line in values {
            if line.isEmpty {
                inMap = false
                print(area)
                print(seeds)
                seedsIndexMoved = []
                tempSeeds = []
                continue
            } else if inMap {
                let mapping = line.split(separator: " ").map(String.init).compactMap(Double.init)
                let destination = mapping[0]
                let origin = mapping[1]
                let range = mapping[2]
                let limit = origin + range - 1
                if area == "fertilizer-to-water map:" {
                    print("wait")
                }
                for (i, seed) in seeds.enumerated() {
                    guard !seedsIndexMoved.contains(i) && seed >= origin && seed <= limit else {
                        continue
                    }
                    seedsIndexMoved.append(i)
                    seeds[i] = seed + (destination - origin)
                }
                var useSeeds: [Double]
                for (i, seed) in seeds2.enumerated() {
                    guard i+1 < seeds2.count else { break }
                    let lastIndex = seeds2[i+1] + seed
                    if seed >= origin {
                        
                    }
                    guard (seed >= origin || lastIndex >= origin) && (seed <= limit || lastIndex <= limit) else { continue }
                    
                }
            } else if line.hasSuffix("map:") {
                area = line
                inMap = true
            } else if line.hasPrefix("seeds:") {
                seeds = line.split(separator: ": ")[1].split(separator: " ").map(String.init).compactMap(Double.init)
                seeds2 = seeds
            }
        }
        print(seeds)
        let result1 = seeds.reduce(99999999) { partialResult, newValue in
            return min(partialResult, newValue)
        }
        let result2 = 1
        print("result 1: \(result1)")
        print("result 2: \(result2)")
    }
    
}
