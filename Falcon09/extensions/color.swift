//
//  color.swift
//  Falcon09
//
//  Created by Виктория on 04.02.2023.
//

import Foundation
import SwiftUI

extension Color {
    init(_ hex: UInt32,
         _ redOut: UnsafeMutablePointer<UInt8>? = nil,
         _ greenOut: UnsafeMutablePointer<UInt8>? = nil,
         _ blueOut: UnsafeMutablePointer<UInt8>? = nil)
    {
        var hex = hex.bigEndian
        let p = UnsafeRawPointer.init(&hex)
        
        let red   = p.load(fromByteOffset: 1, as: UInt8.self)
        let green = p.load(fromByteOffset: 2, as: UInt8.self)
        let blue  = p.load(fromByteOffset: 3, as: UInt8.self)
        
        redOut?.pointee   = red
        greenOut?.pointee = green
        blueOut?.pointee  = blue
        
        self = Color(red: Double(red)/255, green: Double(green)/255, blue: Double(blue)/255)
    }
    
    static var OFEYellow: Color { Color(0xfdd017) }
    static var OFEDarkBlue: Color { Color(0x0c161c) }
    static var OFELightGray: Color { Color(0x949494) }
}
