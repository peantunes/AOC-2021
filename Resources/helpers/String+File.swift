import Foundation

extension String {
    var openFile: String {
        guard let data = try? Data(contentsOf:  URL(fileURLWithPath: "/Users/pedroan/code/Pedro/AOC-2021/Resources/files/\(self)")) else {
            fatalError("error to open file \(self)")
        }

        guard let content = String(data: data, encoding: .utf8) else {
            fatalError("error to convert file \(self)")
        }
        return content
    }
}
