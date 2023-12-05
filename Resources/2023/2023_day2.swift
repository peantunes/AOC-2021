//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

extension AdventOfCode2023 {
    func day2() {
        let start = Date()
        print("*** Starting day 2 ***")
        let content = "2023/2023-day2.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).map(String.init)
        print("number of Lines: \(lines.count)")
        exe1(values: lines)
//        print("result 1: \(rockPaperScissors2(values: lines))")
        print("*** ending day 2 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    private enum Limits {
        static let red = 12
        static let green = 13
        static let blue = 14
        
        static func limit(_ color: String) -> Int {
            switch color {
            case "red":
                return Limits.red
            case "green":
                return Limits.green
            case "blue":
                return Limits.blue
            default:
                return 0
            }
        }
    }
    
    private struct Game {
        struct Bag {
            let colors: [String: Int]
        }
        
        let id: Int
        let bags: [Bag]
        
        var isMinimum: Bool {
            for bag in bags {
                for (color, value) in bag.colors {
                    if value > Limits.limit(color) {
                        return false
                    }
                }
            }
            return true
        }
        
        var minimumNumbers: Int {
            var maxValue = [String: Int]()
            for bag in bags {
                for (color, value) in bag.colors {
                    guard let currentValue = maxValue[color] else {
                        maxValue[color] = value
                        continue
                    }
                    maxValue[color] = max(value, currentValue)
                }
            }
            return maxValue.reduce(1) { partialResult, color in
                partialResult * color.value
            }
        }
    }
    
//    Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
//    Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
//    Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
//    Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
//    Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
    private func exe1(values: [String]) {
        var games: [Game] = []
        for row in values {
            guard !row.isEmpty else { break }
            let content = row.split(separator: ": ")
            let gameNumber = Int(content[0].split(separator: " ")[1])!
            let rounds = Array(content[1].split(separator: "; "))
            
            let bags: [Game.Bag] = rounds.compactMap {
                contentsOfBag(cubes: $0.split(separator: ", ").map(String.init))
            }
            if bags.count < rounds.count {
                continue
            }
            games.append(Game(id: gameNumber, bags: bags))
        }
        
        var result1 = 0
        var result2 = 0
        for game in games {
            result1 += (game.isMinimum ? game.id : 0)
            result2 += game.minimumNumbers
        }
        print("result 1: \(result1)")
        print("result 2: \(result2)")
    }

    private func contentsOfBag(cubes: [String]) -> Game.Bag? {
        var colors = [String: Int]()
        for cube in cubes {
            let colorContent = cube.split(separator: " ")
            let colorValue = Int(colorContent[0])!
            let colorName = String(colorContent[1])
            colors[colorName] = colorValue
        }
        
        return Game.Bag(colors: colors)
    }
    
}
