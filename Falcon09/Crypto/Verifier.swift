//
//  Verifier.swift
//  SwiftHello
//
//  Created by Виктория on 29.10.2022.
//

import Foundation


class Verifier {
    var salt: Data!
    var encryptedVerifier: Data!
    var encryptedVerifierHash: Data!
    
    init() {}
    
    init?(salt: Data, key: Data) {
        do {
            self.salt = salt
            let verifier = try generateRandomData(count: 16)
            self.encryptedVerifier = try encrypt(verifier, withKey: key)
            let verifierHash = try hash(verifier)
            self.encryptedVerifierHash = try encrypt(verifierHash, withKey: key)
        } catch {
            return nil
        }
    }
    
    func verify(_ password: String) throws -> Bool {
        do {
            let key = try deriveKey(password: password, salt: self.salt)
            let verifier = try decrypt(self.encryptedVerifier, withKey: key)
            let hash1 = try decrypt(self.encryptedVerifierHash, withKey: key)
            let hash2 = try hash(verifier)
            return hash1 == hash2
        } catch {
            throw error
        }
    }
}
