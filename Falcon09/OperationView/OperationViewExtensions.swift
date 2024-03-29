//
//  main.swift
//  Falcon09
//
//  Created by Виктория on 11.02.2023.
//

import Foundation
import SwiftUI


extension OperationView {
    var outUrl: URL {
        get { _outUrl.firstObject as! URL }
        nonmutating set { _outUrl[0] = newValue }
    }
    var error: Error? {
        get { _error.firstObject as? Error }
        nonmutating set {
            if let error = newValue {
                _error[0] = error
            }
        }
    }
    
    func main() {
        let queue = DispatchQueue.global(priority: .default)
        queue.async {
            let start = Date()
            do {
                if operation == .encrypt {
                    let outPath = NSTemporaryDirectory() + url.lastPathComponent + ".crypto"
                    outUrl = URL(filePath: outPath)
                    if let securityScopedUrl = url.securityScopedUrl {
                        try securityScopedUrl.read {
                            try Crypto.encrypt(
                                fileAt: $0,
                                withPassword: password,
                                outputTo: outUrl)
                        }
                    } else if let url = url.foundationUrl {
                        try Crypto.encrypt(fileAt: url, withPassword: password, outputTo: outUrl)
                    } else {
                        throw NSError(domain: OpenFileEncryptorDomain, code: 1)
                    }
                } else {
                    var outPath: String
                    if url.pathExtension == "crypto" {
                        let filename = url.lastPathComponent
                        let endIndex = filename.index(filename.endIndex, offsetBy: -7)
                        outPath = NSTemporaryDirectory() + "\(filename[filename.startIndex..<endIndex])"
                    } else {
                        outPath = NSTemporaryDirectory() + url.lastPathComponent
                    }
                    outUrl = URL(filePath: outPath)
                    if let securityScopedUrl = url.securityScopedUrl {
                        try securityScopedUrl.read {
                            try Crypto.decrypt(
                                fileAt: $0,
                                withPassword: password,
                                outputTo: outUrl)
                        }
                    } else if let url = url.foundationUrl {
                        try Crypto.decrypt(fileAt: url, withPassword: password, outputTo: outUrl)
                    }
                }
                let elapsed = Date().timeIntervalSince(start)
                // 3.1 + x = 6
                // 2.1 + x = 6
                var ceiled = Int(ceil(elapsed))
                if ceiled % 3 != 0 {
                    ceiled += 3 - ceiled % 3
                }
                let delay = Int(Double(ceiled)*1000 - elapsed*1000)
                queue.asyncAfter(deadline: .now() + .milliseconds(delay)) {
                    self.animate = false
                }
            } catch {
                self.error = error
                self.isPresentingAlert.toggle()
            }
        }
    }
    
}
