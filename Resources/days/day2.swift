import Foundation

func day2() {
    let start = Date()
    print("*** Starting day 2 ***")
    let content = "input-day2.txt".openFile
    let lines = content.split(separator: "\n").compactMap(SubmarineAction.init(row:))
    print("number of lines: \(lines.count)")
    print("result 1: \(lines.totalPosition)")
    print("result 2: \(lines.totalWithAim)")
    print("*** ending day 2 ***", start.timeIntervalSinceNow)
    print("\n")
}

struct SubmarineAction {
    enum Action: String {
        case forward
        case up
        case down
    }

    let action: Action
    let amount: Int

    init?(row: Substring) {
        let values = row.split(separator:" ")
        guard let action = Action(rawValue: String(values[0])),
              let amount = Int(values[1]) else {
            return nil
        }
        self.action = action
        self.amount = amount
    }
}

private extension Array where Element == SubmarineAction {
    var totalPosition: Int {
        var aim: Int = 0
        var forward: Int = 0
        var depth: Int = 0
        for move in self {
            switch move.action {
            case .up:
                depth -= move.amount
                aim -= move.amount
            case .down:
                depth += move.amount
                aim += move.amount
            case .forward:
                forward += move.amount
            }
        }
//        print("Forward: \(forward) | depht: \(depth)")
        return forward * depth
    }

    var totalWithAim: Int {
        var aim: Int = 0
        var forward: Int = 0
        var depth: Int = 0
        for move in self {
            switch move.action {
            case .up:
                aim -= move.amount
            case .down:
                aim += move.amount
            case .forward:
                forward += move.amount
                depth += aim * move.amount
            }
        }
//        print("Forward: \(forward) | depht: \(depth) | aim: \(aim)")
        return forward * depth
    }
}
