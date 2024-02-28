import CoreData

final class DataTransformer: NSSecureUnarchiveFromDataTransformer {
    // Supported Types
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, NSString.self]
    }

    static func register() {
        ValueTransformer.setValueTransformer(DataTransformer(), forName: NSValueTransformerName(rawValue: String(describing: DataTransformer.self)))
    }
}

