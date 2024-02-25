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
    
    // RGB ➡️ HEX
    func rgbToHex(r: Int, g: Int, b: Int) -> String {
        let hexString = String(format: "%02x%02x%02x", r, g, b)
        return hexString
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
    
    func rgbToAccessibility(_ rgbColor: String) -> String {
        var result = ""
        let rgbArray = rgbColor.components(separatedBy: ",")
                              .prefix(3)
                              .compactMap { Int($0.trimmingCharacters(in: .whitespaces)) }
   
        if rgbArray.count == 3, rgbArray.allSatisfy({ 0...255 ~= $0 }){
            result = "Red\(rgbArray[0]), Green\(rgbArray[1]), Blue\(rgbArray[2])"
        }
        return result
    }
}
