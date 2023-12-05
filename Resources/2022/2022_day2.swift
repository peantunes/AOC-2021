//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2022 {
    func day2() {
        let start = Date()
        print("*** Starting day 2 ***")
        let content = "2022/2022-day2.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(rockPaperScissors(values: lines))")
        print("result 1: \(rockPaperScissors2(values: lines))")
        print("*** ending day 2 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    // A - Rock, B - Paper, C - Scissors
    // X - Rock, Y - Paper, Z - Scissors
    // 1         2          3
    // 0 - loose, 3 - draw, 6 - won
    // AX & BY & CZ = draw
    // AY & BZ & CX = lost
    // AZ & BX & CY = won
    private func rockPaperScissors(values: [String]) -> Double {
        var points = 0.0
        for game in values {
            guard !game.isEmpty else { break }
            let selection = String(game.last!)
            points += selection == "X" ? 1 : selection == "Y" ? 2 : 3
            let row = game.replacingOccurrences(of: " ", with: "")
            if ["AX", "BY", "CZ"].contains(row) {
                points += 3
            } else if ["AY", "BZ", "CX"].contains(row) {
//            } else if ["AZ", "BX", "CY"].contains(row) {
                points += 6
            }
            
            
        }
        return points
    }
    
    private func rockPaperScissors2(values: [String]) -> Double {
        var points = 0.0
        for game in values {
            guard !game.isEmpty else { break }
            let adversary = String(game.first!)
            let selection = String(game.last!)
            if selection == "X" { //lose
                if adversary == "A" { // rock
                    points += 3
                } else if adversary == "B" { // paper
                    points += 1
                } else { // scissors
                    points += 2
                }
            } else if selection == "Y" { //draw
                points += 3
                if adversary == "A" { // rock
                    points += 1
                } else if adversary == "B" { // paper
                    points += 2
                } else { // scissors
                    points += 3
                }
                
            } else if selection == "Z" { //win
                points += 6
                if adversary == "A" { // rock
                    points += 2
                } else if adversary == "B" { // paper
                    points += 3
                } else { // scissors
                    points += 1
                }
            }
        }
        return points
    }
}
