//
//  Size.swift
//  OpenFileEncryptor
//
//  Created by Виктория on 01.11.2022.
//
import Foundation

class Size: NSObject {
    let gigabytes: Double
    let megabytes: Double
    let kilobytes: Double
    let bytes: Double
    
    init(bytes: UInt64) {
        self.bytes = Double(bytes & 0b1111111111)
        self.kilobytes = Double((bytes >> 10) & 0b1111111111)
        self.megabytes = Double((bytes >> 20) & 0b1111111111)
        self.gigabytes = Double(bytes >> 30)
    }
    
    convenience init(bytes: NSNumber) { self.init(bytes: bytes.uint64Value) }
}
