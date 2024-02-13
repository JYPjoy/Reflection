import CoreData

final class AttributeTransformer: NSSecureUnarchiveFromDataTransformer {

    // 지원하는 Custom Type을 명시함
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, NSString.self]
    }

    static func register() {
        ValueTransformer.setValueTransformer(AttributeTransformer(), forName: NSValueTransformerName(rawValue: String(describing: AttributeTransformer.self)))
    }
}

