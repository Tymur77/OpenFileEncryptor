//
//  OFEUrlProtocol.swift
//  Falcon09
//
//  Created by Виктория on 12.02.2023.
//

import Foundation
import SwiftUI


protocol OFEUrlProtocol: Hashable {
    var size: Int? { get }
    func generateThumbnail(_ size: CGSize, _ complitionBlock: @escaping (Image) -> Void)
    var operation: CryptoOperation! { get }
    var lastPathComponent: String { get }
    var pathExtension: String { get }
    var securityScopedWrapper: SecurityScopedUrl { get }
}
