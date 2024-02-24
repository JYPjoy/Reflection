import Foundation

final class ColorManager {
    static let shared = ColorManager()
    
    // HEX ➡️ RGB
    func hexToRGB(hex: String) -> String {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Int((rgb >> 16) & 0xFF)
        let g = Int((rgb >>  8) & 0xFF)
        let b = Int((rgb >>  0) & 0xFF)
        
        return "\(r), \(g), \(b)"
    }
    
    
    func hexToRGBAccessibility(hex: String) -> String {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Int((rgb >> 16) & 0xFF)
        let g = Int((rgb >>  8) & 0xFF)
        let b = Int((rgb >>  0) & 0xFF)
        
        return "Red\(r), Green\(g), Blue\(b)"
    }
    
    
    // RGB ➡️ HEX
    func rgbToHex(r: Int, g: Int, b: Int) -> String {
        let hexString = String(format: "%02x%02x%02x", r, g, b)
        return hexString
    }
    
}
