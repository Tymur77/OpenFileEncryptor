//
//  Codes.swift
//  SwiftHello
//
//  Created by Виктория on 31.10.2022.
//

import Foundation

enum Code: Int {
    case SHA1Error = 500
    case VerifierError = 501
    case PasswordVerificationFailed = 502
    case DocumentError = 503
    case AccessSecurityScopedUrlError = 504
    case DataError = 505
}

extension NSError {
    convenience init(domain: String, code: Code) {
        self.init(domain: domain, code: code.rawValue)
    }
}

let OpenFileEncryptorDomain = "OpenFileEncryptorDomain"
