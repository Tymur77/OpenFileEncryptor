//
//  Screen.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation

enum Screen: Equatable {
    case welcome
    case password(URL, ResourceType)
    case operation(URL, String, ResourceType)
}
