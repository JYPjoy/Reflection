//  Created by Joy on 2/12/24.
//

import SwiftUI

extension Color {
    
    // MARK: - Design System
    enum System {
        /// #FFFFFF
        static var systemWhite: Color { Color("systemWhite") }
        /// #323232
        static var systemBlack: Color { Color("systemBlack") }
    }
    
    enum Main {
        /// #FFFAD9
        static var main10: Color { Color("main10") }

        /// #F8D749
        static var main50: Color { Color("main50") }
    }
 
    enum Text {
        /// #FFFFFF
        static var text10: Color { Color("text10") }
        /// #EBEBEB
        static var text30: Color { Color("text30") }
        /// #9e9e9e
        static var text50: Color { Color("text50") }
        /// #666666
        static var text70: Color { Color("text70") }
        /// #222222
        static var text90: Color { Color("text90") }
        
    }
        
    enum Sub {
        /// #F65252
        static var caution90: Color { Color("caution90") }
        /// #2473FC
        static var notice90: Color { Color("notice90") }
    }
    
    // MARK: - Other Colors which is not included in DesignSystem (What if)
    init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b)
    }
}
