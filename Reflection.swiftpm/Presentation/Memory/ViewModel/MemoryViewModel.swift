import Foundation
import Combine

final class MemoryViewModel: ObservableObject {
    @Published public var colorChipToAdd: ColorChip?
    @Published private var memories: [Memory] = []

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
                self?.memories.insert(memory, at: Int.zero) //append인 insert인지 다시 확인
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

    func updateColorChip() {
        guard let colorChipToAdd = self.colorChipToAdd else { return }
        
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
