//
//  url.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation
import SwiftUI
import QuickLookThumbnailing


extension URL {
    var promisedSize: Int? {
        return try? self.promisedItemResourceValues(forKeys: [.fileSizeKey]).fileSize
    }
    
    var size: Int? {
        return try? self.resourceValues(forKeys: [.fileSizeKey]).fileSize
    }
    
    var fileExists: Bool {
        return FileManager.default.fileExists(atPath: self.path)
    }
    
    var bookmark: Data? {
        return try? self.bookmarkData(options: [.minimalBookmark])
    }
    
    func access(_ accessBlock: () -> Void) {
        if self.startAccessingSecurityScopedResource() {
            accessBlock()
            self.stopAccessingSecurityScopedResource()
        }
    }

    func read(_ readBlock: (URL) throws -> Void) throws {
        var error: NSError?
        var readError: Error?
        NSFileCoordinator().coordinate(readingItemAt: self, error: &error) {
            do {
                try readBlock($0)
            } catch {
                readError = error
            }
        }
        if let error = error {
            throw error
        }
        if let readError = readError {
            throw readError
        }
    }

    func generateThumbnail(_ size: CGSize, _ complitionBlock: @escaping (Image) -> Void) {
        let request = QLThumbnailGenerator.Request(fileAt: self, size: size, scale: 1, representationTypes: [.icon, .thumbnail])
        QLThumbnailGenerator.shared.generateRepresentations(for: request)
        { thumbnail, _, error in
            guard let thumbnail = thumbnail, error == nil else { return }
            let image = Image(uiImage: thumbnail.uiImage)
            complitionBlock(image)
        }
    }
    
    var operation: CryptoOperation { self.pathExtension == "crypto" ? .decrypt : .encrypt }
    
}
