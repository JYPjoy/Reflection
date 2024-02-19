import Foundation
import Combine

final class ColorChipViewModel: ObservableObject {
    @Published private(set) var memories: [Memory] = []
    private(set) var registerDoneSignal = PassthroughSubject<ColorChip, Never>()
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let colorChipUseCase: ColorChipUseCaseProtocol

    init(colorChipUseCase: ColorChipUseCaseProtocol = ColorChipUseCase(coreDataManager: CoreDataManager.shared)) {
        self.colorChipUseCase = colorChipUseCase
    }
    
    func didTapMakeColorChip(colorChip: ColorChip) {
        self.colorChipUseCase.insertColorChip(colorChip)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] colorChip in
                self?.registerDoneSignal.send(colorChip)
            }
            .store(in: &self.cancellables)
    }
    
}
