//
//  AnyOFEUrl.swift
//  Falcon09
//
//  Created by Виктория on 12.02.2023.
//

import Foundation
import SwiftUI


struct AnyOFEUrl: OFEUrlProtocol {
    private let _url: any OFEUrlProtocol
    var url: any OFEUrlProtocol { _url }
    
    init(_ url: any OFEUrlProtocol) {
        _url = url
    }
    
    var size: Int? { self.url.size }
    
    func generateThumbnail(_ size: CGSize, _ complitionBlock: @escaping (Image) -> Void) {
        self.url.generateThumbnail(size, complitionBlock)
    }
    
    var operation: CryptoOperation! { self.url.operation }
    
    var lastPathComponent: String { self.url.lastPathComponent }
    
    var pathExtension: String { self.url.pathExtension }
    
    var securityScopedWrapper: SecurityScopedUrl { self.url.securityScopedWrapper }
    
    static func == (lhs: AnyOFEUrl, rhs: AnyOFEUrl) -> Bool {
        if let url1 = lhs.url as? URL, let url2 = rhs.url as? URL {
            return url1 == url2
        } else if let url1 = lhs.url as? SecurityScopedUrl, let url2 = rhs.url as? SecurityScopedUrl {
            return url1 == url2
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) { self.url.hash(into: &hasher) }
    
}
