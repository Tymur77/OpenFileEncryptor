//
//  SecurityScopedUrl.swift
//  Falcon09
//
//  Created by Виктория on 12.02.2023.
//

import Foundation
import SwiftUI


struct SecurityScopedUrl: OFEUrlProtocol {
    private let url: URL
    
    init(_ securityScopedUrl: URL) {
        url = securityScopedUrl
    }
    
    var size: Int? {
        if self.url.startAccessingSecurityScopedResource() {
            let size = self.url.size
            self.url.stopAccessingSecurityScopedResource()
            return size
        } else {
            return nil
        }
    }
    
    func generateThumbnail(_ size: CGSize, _ complitionBlock: @escaping (Image) -> Void) {
        if self.url.startAccessingSecurityScopedResource() {
            self.url.generateThumbnail(size) {
                complitionBlock($0)
                self.url.stopAccessingSecurityScopedResource()
            }
        }
    }
    
    var operation: CryptoOperation! {
        if self.url.startAccessingSecurityScopedResource() {
            let operation = self.url.operation
            self.url.stopAccessingSecurityScopedResource()
            return operation
        } else {
            return nil
        }
    }
    
    var fileExists: Bool {
        if self.url.startAccessingSecurityScopedResource() {
            let fileExists = FileManager.default.fileExists(atPath: self.url.path)
            self.url.stopAccessingSecurityScopedResource()
            return fileExists
        } else {
            return false
        }
    }
    
    var promisedSize: Int? {
        if self.url.startAccessingSecurityScopedResource() {
            let promisedSize = try? self.url.promisedItemResourceValues(forKeys: [.fileSizeKey]).fileSize
            self.url.stopAccessingSecurityScopedResource()
            return promisedSize
        } else {
            return nil
        }
    }
    
    var bookmark: Data? {
        if self.url.startAccessingSecurityScopedResource() {
            let bookmark = try? self.url.bookmarkData(options: [.minimalBookmark])
            self.url.stopAccessingSecurityScopedResource()
            return bookmark
        } else {
            return nil
        }
    }
    
    func read(_ readBlock: (URL) throws -> Void) throws {
        var error: NSError?
        var readError: Error?
        if self.url.startAccessingSecurityScopedResource() {
            NSFileCoordinator().coordinate(readingItemAt: self.url, error: &error) {
                do {
                    try readBlock($0)
                } catch {
                    readError = error
                }
            }
            self.url.stopAccessingSecurityScopedResource()
            if let error = error {
                throw error
            }
            if let readError = readError {
                throw readError
            }
        } else {
            throw NSError(domain: OpenFileEncryptorDomain, code: .AccessSecurityScopedUrlError)
        }
    }
    
    var lastPathComponent: String {
        if self.url.startAccessingSecurityScopedResource() {
            let filename = self.url.lastPathComponent
            self.url.stopAccessingSecurityScopedResource()
            return filename
        } else {
            return ""
        }
    }
    
    var pathExtension: String {
        if self.url.startAccessingSecurityScopedResource() {
            let ext = self.url.pathExtension
            self.url.stopAccessingSecurityScopedResource()
            return ext
        } else {
            return ""
        }
    }
    
    var securityScopedWrapper: SecurityScopedUrl { self }
    
}
