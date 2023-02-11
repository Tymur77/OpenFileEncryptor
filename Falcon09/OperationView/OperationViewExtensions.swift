//
//  main.swift
//  Falcon09
//
//  Created by Виктория on 11.02.2023.
//

import Foundation
import SwiftUI


extension OperationView {
    func main() {
        let queue = DispatchQueue.global(priority: .default)
        queue.async {
            let start = Date()
            do {
                if operation == .encrypt {
                    var data: Data!
                    if resourceType == .moved {
                        data = try Crypto.encryptFileAt(url, withPassword: password, isSecureScopedUrl: true)
                    } else {
                        data = try Crypto.encryptFileAt(url, withPassword: password)
                    }
                    let outPath = NSTemporaryDirectory() + url.lastPathComponent + ".crypto"
                    outUrl.url = URL(filePath: outPath)
                    try data.write(to: outUrl.url)
                } else {
                    var data: Data!
                    if resourceType == .moved {
                        data = try Crypto.decryptFileAt(url, withPassword: password, isSecureScopedUrl: true)
                    } else {
                        data = try Crypto.decryptFileAt(url, withPassword: password)
                    }
                    var outPath: String
                    if url.pathExtension == "crypto" {
                        let filename = url.lastPathComponent
                        let endIndex = filename.index(filename.endIndex, offsetBy: -7)
                        outPath = NSTemporaryDirectory() + "\(filename[filename.startIndex..<endIndex])"
                    } else {
                        outPath = NSTemporaryDirectory() + url.lastPathComponent
                    }
                    outUrl.url = URL(filePath: outPath)
                    try data.write(to: outUrl.url)
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
                self.error.error = error
                self.isPresentingAlert.toggle()
            }
        }
    }
    
}
