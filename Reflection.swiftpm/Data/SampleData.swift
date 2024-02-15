import SwiftUI

class SampleData {
    static let shared: SampleData = SampleData()
    let context = CoreDataManager.shared.container.viewContext
    
    func createSampleData() {
        let colorChip = ColorChipEntity(context: self.context)
        colorChip.identifier = UUID()
        colorChip.colorName = "하늘색"
        colorChip.colorCount = 2
        colorChip.colorList = ["blue", "pink"]
    }
}
