import Foundation
import Combine

final class MemoryViewModel: ObservableObject {
    @Published public var specificColorChip: ColorChip?
    @Published private(set) var memories: [Memory] = []

    private var cancellables: Set<AnyCancellable> = .init()
    
    private let memoryUseCase: MemoryUseCaseProtocol
    private let colorChipUseCase: ColorChipUseCaseProtocol
    
    init(memoryUseCase: MemoryUseCaseProtocol = MemoryUseCase(coreDataManager: CoreDataManager.shared), colorChipUseCase: ColorChipUseCaseProtocol = ColorChipUseCase(coreDataManager: CoreDataManager.shared)) {
        self.memoryUseCase = memoryUseCase
        self.colorChipUseCase = colorChipUseCase
    }

    func didTapMakeMemory(memory: Memory) {
        self.memoryUseCase.insertMemory(memory)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] memory in
                self?.memories.insert(memory, at: Int.zero)
                self?.updateColorChip()
                self?.memories = []
            }
            .store(in: &self.cancellables)
    }


    func fetchAllMemories() {
        self.memoryUseCase.fetchAllMemory()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] memories in
                Log.n(memories)
            }
            .store(in: &self.cancellables)
    }
    
    func deleteMemory(_ id: UUID) {
        self.memoryUseCase.deleteMemory(id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] memories in
                self?.memories = memories
            }
            .store(in: &self.cancellables)
    }
    
    
    func fetchSpecificColorChip() {
        guard let colorChipToAdd = self.specificColorChip else { return }
        self.colorChipUseCase.fetchSpecificColorChip(colorChipToAdd)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                Log.d(colorChip)
                Log.i(colorChip.memories)
            }
            .store(in: &self.cancellables)
    }

    func updateColorChip() {
        guard let colorChipToAdd = self.specificColorChip else { return }
        
        let newColorChip = ColorChip(id: colorChipToAdd.id, colorName: colorChipToAdd.colorName, colorList: colorChipToAdd.colorList, memories: memories)
        Log.i(newColorChip)
        
        self.colorChipUseCase.updateColorChip(newColorChip)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                Log.d(colorChip)
            }
            .store(in: &self.cancellables)
    }
}
