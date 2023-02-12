//
//  url.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation
import SwiftUI
import QuickLookThumbnailing


extension URL: OFEUrlProtocol {
    var size: Int? { try? self.resourceValues(forKeys: [.fileSizeKey]).fileSize }

    func generateThumbnail(_ size: CGSize, _ complitionBlock: @escaping (Image) -> Void) {
        let request = QLThumbnailGenerator.Request(fileAt: self, size: size, scale: 1, representationTypes: [.icon, .thumbnail])
        QLThumbnailGenerator.shared.generateRepresentations(for: request)
        { thumbnail, _, error in
            guard let thumbnail = thumbnail, error == nil else { return }
            let image = Image(uiImage: thumbnail.uiImage)
            complitionBlock(image)
        }
    }
    
    var operation: CryptoOperation! { self.pathExtension == "crypto" ? .decrypt : .encrypt }
    
    var securityScopedWrapper: SecurityScopedUrl { SecurityScopedUrl(self) }
    
}
