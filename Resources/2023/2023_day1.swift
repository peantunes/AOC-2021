//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

struct AdventOfCode2023 {
    var logEnabled = false
    
    func log(_ items: Any...) {
        if logEnabled {
            print(items)
        }
    }
}

extension AdventOfCode2023 {
    func day1() {
        print("*** Starting day 1 ***")
        let content = "2022/2022-day1.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false)
        print("number of Lines: \(lines.count)")
        print("result 1: \(moreCalories(values: lines.map(String.init)))")
        print("result 2: \(threeMoreCalories(values: lines.map(String.init)))")
//        print("result 2: \(sum2020With3(values: lines))")
//        print("*** ending day 1 ***", start.timeIntervalSinceNow)
//        print("\n")
    }

    private func moreCalories(values: [String]) -> Double {
        var elves = [Double]()
        
        var calories: Double = 0
        for cal in values {
            if cal.isEmpty {
                elves.append(calories)
                calories = 0
            } else {
                calories += Double(cal) ?? 0
            }
        }
        return elves.sorted(by: >).first!
    }
    
    private func threeMoreCalories(values: [String]) -> Double {
        var elves = [Double]()
        
        var calories: Double = 0
        for cal in values {
            if cal.isEmpty {
                elves.append(calories)
                calories = 0
            } else {
                calories += Double(cal) ?? 0
            }
        }
        return elves.sorted(by: >).prefix(3).reduce(0) { $0 + $1 }
    }
}
