//
//  data.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import Foundation


extension Data {
    func resolve() -> URL? {
        var isStale = false
        if let url = try? URL(resolvingBookmarkData: self, bookmarkDataIsStale: &isStale),
           !isStale
        {
            return url
        } else {
            return nil
        }
    }
    
    init(contentsOfSecureScopedUrl url: URL) throws {
        if url.startAccessingSecurityScopedResource() {
            var data: Data!
            // read is not asynchronous
            try url.read { data = try Data(contentsOf: $0) }
            self = data
            url.stopAccessingSecurityScopedResource()
        } else {
            throw NSError(domain: OpenFileEncryptorDomain, code: .AccessSecureScopedUrlError)
        }
    }

}
