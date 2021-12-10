import Foundation

extension AdventOfCode2020 {

    func day5() {
        let start = Date()
        print("*** Starting day 5 ***")
        let content = "2020/2020-day5.txt".openFile
        let lines = content.split(separator: "\n").compactMap(String.init).map {Array($0).map(String.init)}
        let tickets = lines.map(Ticket.init(reference:))
        print("number of Lines: \(lines.count)")
        print("result 1: \(ticketReader(tickets: tickets))")
        print("result 2: \(missingTicket(tickets: tickets))")
        print("*** ending day 5 ***", start.timeIntervalSinceNow)
        print("\n")
    }

    private struct Ticket {
        let row: Int
        let column: Int

        var seatID: Int {
            row * 8 + column
        }

        init(reference: [String]) {
            row = Self.value(Array(reference[0...6]))
            column = Self.value(Array(reference[7...9]), lower: "L")
        }

        static func value(_ reference: [String], lower: String = "F") -> Int {
            var max = (0..<reference.count).reduce(0) {$0 + 2.pow(toPower: $1)}
            var min = 0
            var value = 0
            for i in 0..<reference.count {
                if reference[i] == lower {
                    max = min + (max-min)/2
                    value = max
                } else {
                    min = min + ((max-min+1)/2)
                    value = min
                }
            }
            return value
        }
    }

    private func ticketReader(tickets: [Ticket]) -> Int {
        return tickets.map(\.seatID).sorted().last!
    }

    private func missingTicket(tickets: [Ticket]) -> Int {
        let sorted = tickets.map(\.seatID).sorted()
        print(sorted)
        var previous = sorted[0]
        for i in 1..<tickets.count-1 {
            let current = sorted[i]
            if previous == current-1 {
                previous = current
            } else {
                return current-1
            }
        }
        return previous
    }

}
