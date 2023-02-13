//
//  Crypto.swift
//  SwiftHello
//
//  Created by Виктория on 31.10.2022.
//

import Foundation

class Crypto {
    private init() {}
    
    private class PlistObject: Encodable, Decodable {
        let salt: Data
        let encryptedVerifier: Data
        let encryptedVerifierHash: Data
        
        init(_ verifier: Verifier) {
            self.salt = verifier.salt
            self.encryptedVerifier = verifier.encryptedVerifier
            self.encryptedVerifierHash = verifier.encryptedVerifierHash
        }
    }
    
    static func encrypt(fileAt url: URL, withPassword password: String, outputTo outUrl: URL) throws {
        do {
            let salt = try generateRandomData(count: 16)
            let key = try deriveKey(password: password, salt: salt)
            guard let verifier = Verifier(salt: salt, key: key) else {
                throw NSError(domain: OpenFileEncryptorDomain, code: .VerifierError)
            }
            let plistObject = PlistObject(verifier)
            let plistData = try PropertyListEncoder().encode(plistObject)
            try plistData.write(to: outUrl)
            try Falcon09.encrypt(dataFrom: url, withKey: key, outputTo: outUrl)
        } catch {
            throw error
        }
    }
    
    static func decrypt(fileAt url: URL, withPassword password: String, outputTo outUrl: URL) throws {
        do {
            guard let data = NSMutableData(length: 192) else {
                throw NSError(domain: OpenFileEncryptorDomain, code: .DataError)
            }
            guard let inputStream = InputStream(url: url) else {
                throw NSError(domain: OpenFileEncryptorDomain, code: .InputStreamError)
            }
            inputStream.open()
            let bytesRead = inputStream.read(data.mutableBytes, maxLength: 192)
            if bytesRead != 192 {
                throw NSError(domain: OpenFileEncryptorDomain, code: .InputStreamError)
            }
            let plistObject = try PropertyListDecoder().decode(PlistObject.self, from: data as Data)
            let verifier = Verifier()
            verifier.salt = plistObject.salt
            verifier.encryptedVerifier = plistObject.encryptedVerifier
            verifier.encryptedVerifierHash = plistObject.encryptedVerifierHash
            // verify password
            guard try verifier.verify(password) else {
                throw NSError(domain: OpenFileEncryptorDomain, code: .PasswordVerificationFailed)
            }
            // decrypt
            let salt = plistObject.salt
            let key = try deriveKey(password: password, salt: salt)
            do {
                try Falcon09.decrypt(dataFrom: inputStream, withKey: key, outputTo: outUrl)
            } catch {
                inputStream.close()
                throw error
            }
            inputStream.close()
        } catch {
            throw error
        }
    }
}
