import SwiftUI
import Combine

final class OnboardingViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = .init()
    private let memoryUseCase: MemoryUseCaseProtocol
    private let colorChipUseCase: ColorChipUseCaseProtocol
    
    init(memoryUseCase: MemoryUseCaseProtocol = MemoryUseCase(coreDataManager: CoreDataManager.shared), colorChipUseCase: ColorChipUseCaseProtocol = ColorChipUseCase(coreDataManager: CoreDataManager.shared)) {
        self.memoryUseCase = memoryUseCase
        self.colorChipUseCase = colorChipUseCase
    }
    
    func didTapMakeColorChip(colorChip: ColorChip) {
        self.colorChipUseCase.insertColorChip(colorChip)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                Log.t(colorChip)
            }
            .store(in: &self.cancellables)
    }
    
    func didTapMakeMemory(memory: Memory) {
        self.memoryUseCase.insertMemory(memory)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { memory in
                Log.t(memory)
            }
            .store(in: &self.cancellables)
    }
}
