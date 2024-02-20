import Foundation
import Combine

final class MemoryViewModel: ObservableObject {
    @Published private(set) var memories: [Memory] = []

    private var cancellables: Set<AnyCancellable> = .init()
    private let memoryUseCase: MemoryUseCaseProtocol
    
    init(memoryUseCase: MemoryUseCaseProtocol = MemoryUseCase(coreDataManager: CoreDataManager.shared)) {
        self.memoryUseCase = memoryUseCase
    }

}
