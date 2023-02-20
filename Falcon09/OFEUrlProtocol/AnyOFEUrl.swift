//
//  AnyOFEUrl.swift
//  Falcon09
//
//  Created by Виктория on 12.02.2023.
//

import Foundation
import SwiftUI


struct AnyOFEUrl: OFEUrlProtocol {
    private var url: any OFEUrlProtocol
    var foundationUrl: URL? { self.url as? URL }
    var securityScopedUrl: SecurityScopedUrl? { self.url as? SecurityScopedUrl }
    
    init(_ url: any OFEUrlProtocol) {
        self.url = url
    }
    
    var size: Int? { self.url.size }
    
    func generateThumbnail(_ size: CGSize, _ complitionBlock: @escaping (Image) -> Void) {
        self.url.generateThumbnail(size, complitionBlock)
    }
    
    var operation: CryptoOperation! { self.url.operation }
    
    var lastPathComponent: String { self.url.lastPathComponent }
    
    var pathExtension: String { self.url.pathExtension }
    
    static func == (lhs: AnyOFEUrl, rhs: AnyOFEUrl) -> Bool {
        if let url1 = lhs.foundationUrl, let url2 = rhs.foundationUrl {
            return url1 == url2
        } else if let url1 = lhs.securityScopedUrl, let url2 = rhs.securityScopedUrl {
            return url1 == url2
        } else {
            return false
        }
    }
    
    func hash(into hasher: inout Hasher) { self.url.hash(into: &hasher) }
    
}
