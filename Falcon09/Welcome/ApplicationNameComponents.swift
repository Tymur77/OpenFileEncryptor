//
//  ApplicationNameComponents.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import Foundation


enum ApplicationNameComponent: String {
    case Open = "O P E N"
    case File = "F I L E"
    case Encryptor = "E N C R Y P T O R"
    case all = "O P E N  F I L E  E N C R Y P T O R"
}


func sum(
    _ components: ApplicationNameComponent...,
    withAttributes attributes: [NSAttributedString.Key: Any]
) -> CGFloat {
    return components.map { String($0).size(withAttributes: attributes).width }.sum()
}
