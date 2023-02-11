//
//  string.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation


extension String {
    init(_ component: ApplicationNameComponent) {
        self = component.rawValue
    }
    
    init(_ size: Size) {
        if size.gigabytes > 0 {
            let value = size.gigabytes + size.megabytes/1000
            self = "\(value.round(2)) GB"
        } else if size.megabytes > 0 {
            let value = size.megabytes + size.kilobytes/1000
            self = "\(value.round(2)) MB"
        } else if size.kilobytes > 0 {
            let value = size.kilobytes + size.bytes/1000
            self = "\(value.round(2)) KB"
        } else {
            self = "\(size.bytes) B"
        }
    }
    
    func size(withAttributes attributes: [NSAttributedString.Key: Any]) -> CGSize {
        (self as NSString).size(withAttributes: attributes)
    }
    
}
