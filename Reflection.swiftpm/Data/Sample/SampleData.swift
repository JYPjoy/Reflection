import SwiftUI

class SampleData {
    static let shared: SampleData = SampleData()
    let context = CoreDataManager.shared.persistentContainer.viewContext
    
    func createSampleData() {
        let colorChip = ColorChipEntity(context: self.context)
        colorChip.identifier = UUID()
        colorChip.colorName = "하늘색"
        colorChip.colorList = "blue"
        let memories = self.createMemory(color: colorChip)
        colorChip.addMemory(values: NSSet(array: memories))
    }
    
    func createMemory(color: ColorChipEntity) -> [MemoryEntity] {
        let memory = MemoryEntity(context: context)
        memory.identifier = UUID()
        memory.title = "메모리1"
        memory.reflection = "소감"
        memory.addColorChip(values: NSSet(array: [color]))
        return []
    }
}