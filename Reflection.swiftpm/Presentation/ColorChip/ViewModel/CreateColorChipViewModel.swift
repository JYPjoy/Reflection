import Foundation

final class CreateColorChipViewModel {
    @Published private(set) var colorChip: ColorChip?
    private let colorChipUseCase: ColorChipUseCaseProtocol
    
    init(colorChipUseCase: ColorChipUseCaseProtocol = ColorChipUseCase(coreDataManager: CoreDataManager.shared)) {
        self.colorChipUseCase = colorChipUseCase
    }
    
}
