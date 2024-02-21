import Foundation
import Combine

protocol MemoryUseCaseProtocol {
    func insertMemory(_ memory: Memory) -> AnyPublisher<Memory, CoreDataManager.CoreDataError>
    
    func fetchAllMemory() -> AnyPublisher<[Memory], CoreDataManager.CoreDataError>
}

final class MemoryUseCase: MemoryUseCaseProtocol {
    
    private var coreDataManager: MemoryManagable
    
    init(coreDataManager: MemoryManagable = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func insertMemory(_ memory: Memory) -> AnyPublisher<Memory, CoreDataManager.CoreDataError> {
        self.coreDataManager.insertMemory(memory)
            .map{ $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchAllMemory() -> AnyPublisher<[Memory], CoreDataManager.CoreDataError> {
        self.coreDataManager.fetchAllMemory()
            .map{ memory in
                memory.map{ $0.toDomain() }.sorted(by: <)
            }
            .eraseToAnyPublisher()
    }
}
