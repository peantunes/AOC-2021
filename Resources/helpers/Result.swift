import Foundation

struct  Result {
    private let day: Int
    private let solution1: () -> Int
    private let solution2: () -> Int
    private let numberOfLines: Int

    init(day: Int,
         numberOfLines: Int,
         solution1: @escaping () -> Int,
         solution2: @escaping () -> Int) {
        self.day = day
        self.numberOfLines = numberOfLines
        self.solution1 = solution1
        self.solution2 = solution2
    }

    func run() {
        let start = Date()
        print("*** Starting day \(day) ***")
        print("number of lines: \(numberOfLines)")
        print("result 1: \(solution1())")
        print("result 2: \(solution2())")
        print("time: \(abs(start.timeIntervalSinceNow))")
        print("*** ending day \(day) ***\n")
    }
}
