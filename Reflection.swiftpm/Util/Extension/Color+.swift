//
//  File.swift
//  
//
//  Created by Joy on 2/12/24.
//

import SwiftUI

extension Color {
    
    // MARK: Design System
    public static var systemWhite: Color {
        Color("systemWhite", bundle: nil)
    }
    
    public static var systemBlack: Color {
        Color("systemBlack", bundle: nil)
    }
    
    public static var main10: Color {
        Color("main10", bundle: nil)
    }
    
    public static var main50: Color {
        Color("main50", bundle: nil)
    }
    
    public static var text10: Color {
        Color("text10", bundle: nil)
    }
    
    public static var text30: Color {
        Color("text30", bundle: nil)
    }
    
    public static var text50: Color {
        Color("text50", bundle: nil)
    }
    
    public static var text70: Color {
        Color("text70", bundle: nil)
    }
    
    public static var text90: Color {
        Color("text90", bundle: nil)
    }
    
    public static var caution90: Color {
        Color("caution90", bundle: nil)
    }
    
    public static var notice90: Color {
        Color("notice90", bundle: nil)
    }
    
    // MARK: Other Colors which is not included in DesignSystem (What if)
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
