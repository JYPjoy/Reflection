import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {
    
    @Published public var exampleColorChip: ColorChip?
    @Published private(set) var memoriesToAdd: [Memory] = []
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let memoryUseCase: MemoryUseCaseProtocol
    private let colorChipUseCase: ColorChipUseCaseProtocol
    
    init(memoryUseCase: MemoryUseCaseProtocol = MemoryUseCase(coreDataManager: CoreDataManager.shared), colorChipUseCase: ColorChipUseCaseProtocol = ColorChipUseCase(coreDataManager: CoreDataManager.shared)) {
        self.memoryUseCase = memoryUseCase
        self.colorChipUseCase = colorChipUseCase
    }
    
    func didTapMakeColorChip(colorChip: ColorChip) {
        self.colorChipUseCase.insertColorChip(colorChip)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                Log.t(colorChip)
                self.exampleColorChip = colorChip
            }
            .store(in: &self.cancellables)
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
    
    func updateColorChip() {
        guard let colorChipToAdd = self.exampleColorChip else { return }
        
        let newColorChip = ColorChip(id: colorChipToAdd.id, colorName: colorChipToAdd.colorName, colorList: colorChipToAdd.colorList, memories: memoriesToAdd)
        
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
