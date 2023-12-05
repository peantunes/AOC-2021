//
//  2022_day1.swift
//  AdventOfCode
//
//  Created by Pedro Antunes on 04/12/2022.
//

import Foundation

protocol Child: AnyObject {
    var name: String { get }
    var totalSize: Int { get }
}

extension AdventOfCode2022 {
    func day7() {
        logEnabled = true
        let start = Date()
        print("*** Starting day 7 ***")
        let content = "2022/2022-day7.txt".openFile
        let lines = content.split(separator: "\n").map(String.init)
        print("number of Lines: \(lines.count)")
        print("result 1: \(readTotalFiles(lines: lines))")
        print("result 2: \(minimumWaste(lines: lines))")
        print("*** ending day 7 ***", start.timeIntervalSinceNow)
        print("\n")
    }
    
    
    class Directory: NSObject, Child {
        
        class File: NSObject, Child {
            static func == (lhs: AdventOfCode2022.Directory.File, rhs: AdventOfCode2022.Directory.File) -> Bool {
                lhs.name == lhs.name
            }
            
            let name: String
            let totalSize: Int
            init(name: String, totalSize: Int) {
                self.name = name
                self.totalSize = totalSize
            }
        }
        let name: String
        var parent: Directory?
        var children: [Child]
        
        init(name: String, parent: Directory?, children: [Child]) {
            self.name = name
            self.parent = parent
            self.children = children
        }
        
        var totalSize: Int {
            children.reduce(0, { $0 + $1.totalSize })
        }
    }
    
    private func readTotalFiles(lines: [String]) -> Int {
        let root = readFromRoot(lines: lines)
        var d = [Directory]()
        printTree(root: root, d: &d)
        return d.reduce(0, { $0 + $1.totalSize })
    }
    
    private func minimumWaste(lines: [String]) -> Int {
        let root = readFromRoot(lines: lines)
        var d = [root]
        let limit = 70000000 - root.totalSize
        let target = 30000000 - limit
        printTree(root: root, d: &d, limit: 100000000)
        
        let found = d.filter { $0.totalSize > target }.sorted(by: { $0.totalSize < $1.totalSize })
//        found.forEach { print("\($0.name) - \($0.totalSize)")}
        return found.first?.totalSize ?? 0
    }
    
    private func readFromRoot(lines: [String]) -> Directory {
        let root = Directory(name: "/", parent: nil, children: [])
        var currentDir: Directory = root
        var i = 0
        while i < lines.count {
            let line = lines[i]
            guard !line.isEmpty else { break }
            let command = line.replacingOccurrences(of: "$ ", with: "").split(separator: " ")
            switch command.first {
            case "cd":
                let dir = String(command.last!)
                switch dir {
                case "..":
                    currentDir = currentDir.parent ?? root
                case "/":
                    currentDir = root
                default:
                    let child: Directory = currentDir.children.first(where: { $0.name == dir }) as? Directory ?? Directory(name: dir, parent: currentDir, children: [])
                    currentDir.children.append(child)
                    currentDir = child
                }
                i += 1
            case "ls":
                var children: [Child] = []
                i += 1
                while true {
                    guard i < lines.count else { break }
                    let line = lines[i].split(separator: " ")
                    guard line.first != "$" else { break }
                    if line.first != "dir" {
                        children.append(Directory.File(name: String(line.last!), totalSize: Int(String(line.first!)) ?? 0))
                    }
                    i += 1
                }
                currentDir.children = children
                continue
            default: // file
                fatalError("Should not be here")
            }
            
        }
        return root
    }
    
    private func printTree(root: Directory, d: inout [Directory], limit: Int = 100000, level: Int = 0) {
        let spaces = String(repeating: "-", count: level)
        log(spaces + "| \(root.name) (dir)")
        for item in root.children {
            if let file = item as? Directory.File {
                log(spaces + "-| \(file.name) (size=\(file.totalSize))")
            } else if let dir = item as? Directory {
                let totalSize = dir.totalSize
                if totalSize <= limit {
                    d.append(dir)
                    printTree(root: dir, d: &d, limit: limit, level: level + 1)
                }
            }
        }
    }
}
