//
//  Operations.swift
//  SwiftHello
//
//  Created by Виктория on 31.10.2022.
//

import Foundation


func generateRandomData(count: Int) throws -> Data {
    var bytes = [UInt8](repeating: 0, count: count)
    let status = SecRandomCopyBytes(kSecRandomDefault, count, &bytes)
    guard status == errSecSuccess else {
        throw NSError(domain: OpenFileEncryptorDomain, code: Int(status))
    }
    return Data(bytes: &bytes, count: count)
}

func deriveKey(password: String, salt: Data, iterations: Int = 100000) throws -> Data {
    let op = QCCPBKDF2SHAKeyDerivation(algorithm: .SHA2_512, passwordString: password, saltData: salt)
    op.rounds = iterations
    op.derivedKeyLength = 32
    op.main()
    guard op.error == nil, let key = op.derivedKeyData else { throw op.error! }
    return key
}

func encrypt(_ data: Data, withKey key: Data) throws -> Data {
    let op = QCCAESPadCryptor(toEncryptInputData: data, keyData: key)
    op.main()
    guard op.error == nil, let outputData = op.outputData else { throw op.error! }
    return outputData
}

func decrypt(_ data: Data, withKey key: Data) throws -> Data {
    let op = QCCAESPadCryptor(toDecryptInputData: data, keyData: key)
    op.main()
    guard op.error == nil, let outputData = op.outputData else { throw op.error! }
    return outputData
}

func hash(_ data: Data) throws -> Data {
    let op = QCCSHADigest(algorithm: .SHA1, inputData: data)
    op.main()
    guard let hash = op.outputDigest else {
        throw NSError(domain: OpenFileEncryptorDomain, code: .SHA1Error)
    }
    return hash
}
