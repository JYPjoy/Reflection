import Foundation
import Combine

protocol ColorChipRepository {
    func createColorChip() -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError>
    func readAllColorChip() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError>
    func updateColorChip() -> AnyPublisher<ColorChip, CoreDataManager.CoreDataError>
    func deleteColorChip() -> AnyPublisher<[ColorChip], CoreDataManager.CoreDataError>
}
