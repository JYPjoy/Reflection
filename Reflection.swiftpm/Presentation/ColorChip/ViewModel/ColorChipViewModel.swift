import Foundation
import Combine

final class ColorChipViewModel: ObservableObject {
    @Published private(set) var colorChipList: [ColorChip] = []
    @Published private(set) var memories: [Memory] = []
    
    @Published public var colorChipToEdit: ColorChip?
    
    private(set) var registerDoneSignal = PassthroughSubject<ColorChip, Never>()
    private(set) var deleteDoneSignal = PassthroughSubject<Void, Never>()
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
    
    func updateColorChip(_ colorChip: ColorChip) {
        print(colorChip)
        self.colorChipUseCase.updateColorChip(colorChip)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { colorChip in
                self.registerDoneSignal.send(colorChip)
            }
            .store(in: &self.cancellables)
    }
    
    func deleteColorChip(_ id: UUID) {
        self.colorChipUseCase.deleteColorChip(id: id)
            .receive(on: RunLoop.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] colorChipList in
                self?.colorChipList = colorChipList
                self?.deleteDoneSignal.send()
            }
            .store(in: &self.cancellables)
    }
}
