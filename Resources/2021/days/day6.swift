import Foundation

func day6() -> Result {
    let values = "3,4,3,1,2".split(separator: ",").map(String.init).compactMap(Int.init)

    return Result(day: 6,
                  numberOfLines: values.count,
                  solution1: { lanternfish1(values: values, day: 1, daysLimit: 80).count },
                  solution2: { calc(begin: 1, end: 256, data: values.toDict) })

}

private extension Array where Element == Int {
    var toDict: [Int: Int] {
        reduce([Int: Int]()) { result, element in
            var result1 = result
            if result1[element] != nil {
                result1[element]! += 1
            } else {
                result1[element] = 1
            }
            return result1
        }
    }
}

private func lanternfish1(values: [Int], day: Int, daysLimit: Int = 18) -> [Int] {
    if day > daysLimit {
        return values
    }
    var newValues = [Int]()
    var newLanternfishs = 0
    for value in values {
        if value <= 0 {
            newValues.append(6)
            newLanternfishs += 1
        } else {
            newValues.append(value-1)
        }
    }
    newValues.append(contentsOf: Array(repeating: 8, count: newLanternfishs))
//    print("After\t\(day): \(newValues.first!) - \(newValues.count)")
//        print("After\t\(day): \(newValues.map(String.init).joined(separator: ","))")

    return lanternfish1(values: newValues, day: day+1, daysLimit: daysLimit)
}

func calc(begin: Int, end: Int, data: [Int: Int]) -> Int {
    var newData = data
    for _ in begin...end {
        var temp = [Int: Int]()
        temp[6] = newData[0] ?? 0
        temp[8] = newData[0] ?? 0
        for y in 1...9 {
            temp[y-1] = (temp[y-1] ?? 0) + (newData[y] ?? 0)
        }
        newData = temp
    }
    return newData.reduce(0, { $0 + $1.value })
}

/*
After one day, its internal timer would become 2.
After another day, its internal timer would become 1.
After another day, its internal timer would become 0.
After another day, its internal timer would reset to 6, and it would create a new lanternfish with an internal timer of 8.
After another day, the first lanternfish would have an internal timer of 5, and the second lanternfish would have an internal timer of 7.

 3
 0, 8
 0, 2, 8
 4, 0, 6, 8
 0, 2, 2, 4, 8
 4, 0, 0, 2, 6, 8, 8
 2, 4, 4, 0, 4, 6, 6, 8
 0, 2, 2, 4, 2, 4, 4, 6, 8
 4, 0, 0, 2, 0, 2, 2, 4, 6, 8, 8, 8


 0
 6, 8 (0)
 6, 1, 8 (0)
 4, 6, 6, 8 (1)
 6, 1, 1, 3, 8 (0)
 4, 6, 6, 1, 6, 8, 8 (1,2)
 2, 4, 4, 6, 4, 6, 6, 8 (3)
 6, 1, 1, 3, 1, 3, 3, 5, 8 (0)

 18 dias
 primeiro ciclo 9
 cada 7 ciclos

 ciclo1 = 9
 dias/ciclo = filhos
 18/7 = 2

 18/2
 (dias/2 - ciclo1)/7

 18 - 26
 80 - 5934
 256 - 26984457539

 5934 - 346063
 26984457539 -

 */


