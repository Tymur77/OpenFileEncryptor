//
//  data.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import Foundation


extension Data {
    func resolve() -> SecurityScopedUrl? {
        var isStale = false
        if let securityScopedUrl = try? URL(resolvingBookmarkData: self, bookmarkDataIsStale: &isStale).securityScopedWrapper,
           !isStale
        {
            return securityScopedUrl
        } else {
            return nil
        }
    }
    
    init(contentsOf securityScopedUrl: SecurityScopedUrl) throws {
        do {
            var data: Data!
            // read is not asynchronous
            try securityScopedUrl.read { data = try Data(contentsOf: $0) }
            self = data
        } catch {
            throw error
        }
    }
    
    init(contentsOf url: AnyOFEUrl) throws {
        if let securityScopedUrl = url.securityScopedUrl {
            self = try Data(contentsOf: securityScopedUrl)
        } else if let url = url.foundationUrl {
            self = try Data(contentsOf: url)
        } else {
            throw NSError(domain: OpenFileEncryptorDomain, code: .DataError)
        }
    }

}
