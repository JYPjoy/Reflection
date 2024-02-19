import Foundation
import Combine

final class ColorChipViewModel: ObservableObject {
    @Published public var colorChipList: [ColorChip] = []
    @Published private(set) var memories: [Memory] = []
    private(set) var registerDoneSignal = PassthroughSubject<ColorChip, Never>()
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let colorChipUseCase: ColorChipUseCaseProtocol

    init(colorChipUseCase: ColorChipUseCaseProtocol = ColorChipUseCase(coreDataManager: CoreDataManager.shared)) {
        self.colorChipUseCase = colorChipUseCase
        self.fetchAllColorChips()
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
    
    func fetchAllColorChips() {
        self.colorChipUseCase.fetchAllColorChip()
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] colorChipList in
                self?.colorChipList = colorChipList
            }
            .store(in: &self.cancellables)
    }
    
    
}
