import Foundation

extension AdventOfCode2020 {

    func day4() {
        let start = Date()
        print("*** Starting day 4 ***")
        let content = "2020/2020-day4.txt".openFile
        let lines = content.split(separator: "\n", omittingEmptySubsequences: false).compactMap(String.init)
        let passports = readPassports(lines: lines)
        print("number of Lines: \(lines.count)")
        print("result 1: \(simpleValidPassports(passports: passports))")
        print("result 2: \(validPassports(passports: passports))")
        print("*** ending day 4 ***", start.timeIntervalSinceNow)
        print("\n")
    }

    private struct Height {
        let value: Int
        let type: String
        init?(_ string: String) {
            guard string.count > 2 else {
                return nil
            }
            var items = string
            let suffix = String(items.suffix(2))
            items.removeLast(2)
            guard suffix == "cm" || suffix == "in" else {
                return nil
            }
            type = suffix
            value = Int(items) ?? 0
        }

        var isValid: Bool {
            if type == "cm" {
                return value >= 150 && value <= 193
            } else {
                return value >= 59 && value <= 76
            }
        }
    }

    private static let fieldKeys = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"]

    private static let eyeColours = ["amb","blu","brn","gry","grn","hzl","oth"]

    private func validPassports(passports: [[String: String]]) -> Int {
        return passports.filter {
            guard let birthday = Int($0["byr"] ?? "a"),
                  let issueYear = Int($0["iyr"] ?? "a"),
                  let expirationYear = Int($0["eyr"] ?? "a"),
                  let height = Height($0["hgt"] ?? ""),
                  let hairColor = $0["hcl"],
                  let eyeColor = $0["ecl"],
                  let pid = $0["pid"] else {
                return false
            }

            guard birthday >= 1920 && birthday <= 2002,
               issueYear >= 2010 && issueYear <= 2020,
               expirationYear >= 2020 && expirationYear <= 2030,
               height.isValid,
               hairColor.isHex(),
               Self.eyeColours.contains(eyeColor),
               pid.isNumeric(),
               pid.count == 9
               else {
                return false
            }
            return true
        }.count
    }

    private func simpleValidPassports(passports: [[String: String]]) -> Int {
        return passports.filter {
            if $0.keys.count < 7 {
                return false
            } else if $0.keys.count < 8 {
                return $0["cid"] == nil
            } else {
                return true
            }
        }.count
    }

    private func readPassports(lines: [String]) -> [[String: String]] {
        var passports = [[String: String]]()
        var currentPassport = [String: String]()
        for line in lines {
            guard !line.isEmpty else {
                passports.append(currentPassport)
                currentPassport = [String: String]()
                continue
            }
            let fieldsWithValue = line.split(separator: " ")
            fieldsWithValue.forEach { field in
                let item = String(field).split(separator: ":").map(String.init)
                currentPassport[item[0]] = item[1]
            }
        }

        return passports
    }

}

private extension String {
    func isNumeric() -> Bool {
        let numbers = "0123456789"
        return filter(numbers.contains).count == count
    }

    func isHex() -> Bool {
        let hexadecimal = "0123456789abcdef"
        return first == "#" && dropFirst().filter(hexadecimal.contains).count == 6

    }
}
