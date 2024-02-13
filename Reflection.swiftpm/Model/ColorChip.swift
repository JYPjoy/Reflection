import Foundation
import CoreData

@objc(ColorChip)
class ColorChip: NSManagedObject {
    @NSManaged var identifier: UUID
    @NSManaged var colorName: String
    @NSManaged var colorList: [String]
    //@NSManaged var memories: NSSet
}

extension ColorChip: Identifiable {
    var id: UUID {
        identifier
    }
    
//    /// Add memories to the ColorChip
//    func addMemory(values: NSSet) {
//        values.forEach { self.mutableSetValue(forKey: "memories").add($0) }
//    }
//    
//    /// Remove memories from the Colorchip
//    func removeMemory(values: NSSet) {
//        values.forEach { self.mutableSetValue(forKey: "memories").remove($0) }
//    }
}



//@objc(CustomClassValueTransformer)
//final class CustomClassValueTransformer: NSSecureUnarchiveFromDataTransformer {
//
//    static let name = NSValueTransformerName(rawValue: String(describing: CustomClassValueTransformer.self))
//
//    // Make sure `CustomClass` is in the allowed class list,
//    // AND any other classes that are encoded in `CustomClass`
//    override static var allowedTopLevelClasses: [AnyClass] {
//        // for example... yours may look different
//        return [String.self]
//    }
//
//    /// Registers the transformer.
//    public static func register() {
//        let transformer = CustomClassValueTransformer()
//        ValueTransformer.setValueTransformer(transformer, forName: name)
//    }
//}


class SecureTransformer: NSSecureUnarchiveFromDataTransformer {
    // 여기에서 지원하는 클래스 타입을 명시합니다.
    override static var allowedTopLevelClasses: [AnyClass] {
        return [NSArray.self, NSString.self]
    }

    static func register() {
        let transformerName = NSValueTransformerName(rawValue: String(describing: SecureTransformer.self))
        let transformer = SecureTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: transformerName)
    }
}
