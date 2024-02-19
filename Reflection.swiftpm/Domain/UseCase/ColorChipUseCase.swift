import Foundation
import Combine

protocol ColorChipUseCaseProtocol {
    func insertColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError>
    
    func fetchAllColorChip() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError>
//
//    func updateColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError>
    func deleteColorChip(id: UUID) -> AnyPublisher<Void, CoreDataManager.CoreDataError>
}

final class ColorChipUseCase: ColorChipUseCaseProtocol {

    private var coreDataManager: ColorChipManagable
    
    init(coreDataManager: ColorChipManagable = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func insertColorChip(_ colorChip: ColorChip) -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError> {
        self.coreDataManager.insertColorChip(colorChip)
            .map{ $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func fetchAllColorChip() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError> {
        self.coreDataManager.fetchAllColorChip()
            .map{ colorchipList in
                colorchipList.map{ $0.toDomain() }.sorted(by: <)
            }
            .eraseToAnyPublisher()
    }
    
    func deleteColorChip(id: UUID) -> AnyPublisher<Void, CoreDataManager.CoreDataError> {
        return self.coreDataManager.deleteColorChip(id: id)
    }
}
