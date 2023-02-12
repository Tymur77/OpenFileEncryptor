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
        let secureData: Data
        
        init(_ verifier: Verifier, _ secureData: Data) {
            self.salt = verifier.salt
            self.encryptedVerifier = verifier.encryptedVerifier
            self.encryptedVerifierHash = verifier.encryptedVerifierHash
            self.secureData = secureData
        }
    }
    
    static func encryptFileAt(_ url: AnyOFEUrl, withPassword password: String) throws -> Data {
        do {
            let salt = try generateRandomData(count: 16)
            let key = try deriveKey(password: password, salt: salt)
            guard let verifier = Verifier(salt: salt, key: key) else {
                throw NSError(domain: OpenFileEncryptorDomain, code: .VerifierError)
            }
            let data = try Data(contentsOf: url)
            let secureData = try encrypt(data, withKey: key)
            let plistObject = PlistObject(verifier, secureData)
            return try PropertyListEncoder().encode(plistObject)
        } catch {
            throw error
        }
    }
    
    static func decryptFileAt(_ url: AnyOFEUrl, withPassword password: String) throws -> Data {
        do {
            let data = try Data(contentsOf: url)
            let plistObject = try PropertyListDecoder().decode(PlistObject.self, from: data)
            let verifier = Verifier()
            verifier.salt = plistObject.salt
            verifier.encryptedVerifier = plistObject.encryptedVerifier
            verifier.encryptedVerifierHash = plistObject.encryptedVerifierHash
            let secureData = plistObject.secureData
            // verify password
            guard try verifier.verify(password) else {
                throw NSError(domain: OpenFileEncryptorDomain, code: .PasswordVerificationFailed)
            }
            // decrypt
            let salt = plistObject.salt
            let key = try deriveKey(password: password, salt: salt)
            return try decrypt(secureData, withKey: key)
        } catch {
            throw error
        }
    }
}
