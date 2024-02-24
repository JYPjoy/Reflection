import Foundation
import Combine

final class MemoryViewModel: ObservableObject {

    @Published public var specificColorChip: ColorChip?
    @Published public var specificColorChipMemories: [Memory] = []
    
    @Published private(set) var memoriesToAdd: [Memory] = []
    @Published public var memoryToEdit: Memory?

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
                self?.memoriesToAdd.insert(memory, at: Int.zero)
                self?.updateColorChip()
                self?.memoriesToAdd = []
            }
            .store(in: &self.cancellables)
    }

    func fetchAllMemories() {
        self.memoryUseCase.fetchAllMemory()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { memories in
                Log.n(memories)
            }
            .store(in: &self.cancellables)
    }
    
    func updateMemory(_ memory: Memory) {
        self.memoryUseCase.updateMemory(memory)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { memory in
                Log.n("Edited Memory is" + "\(memory)")
            }
            .store(in: &self.cancellables)
    }
    
    func deleteMemory(_ id: UUID) {
        self.memoryUseCase.deleteMemory(id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] memories in
                self?.specificColorChipMemories = memories
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
    
    func fetchSpecificColorChipMemories() {
        guard let specificColorChipMemories = self.specificColorChip else {return}
        self.colorChipUseCase.fetchSpecificColorChip(specificColorChipMemories)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                self.specificColorChipMemories = colorChip.memories
            }
            .store(in: &self.cancellables)
    }
    
    func updateColorChip() {
        guard let colorChipToAdd = self.specificColorChip else { return }
        
        let newColorChip = ColorChip(id: colorChipToAdd.id, colorName: colorChipToAdd.colorName, colorList: colorChipToAdd.colorList, memories: memoriesToAdd)
        
        self.colorChipUseCase.updateColorChip(newColorChip)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                Log.d(colorChip)
                self.specificColorChipMemories = colorChip.memories
            }
            .store(in: &self.cancellables)
    }
}
