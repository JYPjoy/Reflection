import Foundation

extension String {
  subscript(_ index: Int) -> Character {
    return self[self.index(self.startIndex, offsetBy: index)]
  }

  subscript(_ range: Range<Int>) -> String {
    let fromIndex = self.index(self.startIndex, offsetBy: range.startIndex)
    let toIndex = self.index(self.startIndex, offsetBy: range.endIndex)

    return String(self[fromIndex..<toIndex])
  }
}
