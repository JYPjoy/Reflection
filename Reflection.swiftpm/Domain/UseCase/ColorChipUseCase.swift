import Foundation
import Combine

protocol ColorChipUseCase {
    func createColorChip() -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError>
    
    func readColorChip() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError>
    func readColorChipNameList() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError>
    
    func updateColorChip() -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError>
    func deleteColorChip() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError>
}


//DataUseCaseImpl: ColorchipUseCase
