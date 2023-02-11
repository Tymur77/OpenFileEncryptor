//
//  dictionary.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation


extension Dictionary {
    func contains(_ key: Key) -> Bool { self.contains(where: { $0.key == key }) }
}
