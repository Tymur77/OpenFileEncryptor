//
//  Falcon09App.swift
//  Falcon09
//
//  Created by Виктория on 03.02.2023.
//

import SwiftUI


@main
struct Falcon09App: App {
    @State var screen = Screen.welcome
    let thumbnail = OFEThumbnail()
    
    var body: some Scene {
        WindowGroup {
            switch screen {
            case .welcome:
                Welcome(screen: $screen, thumbnail: thumbnail)
            case let .password(url):
                PasswordView(screen: $screen, thumbnail: thumbnail, url: url, operation: url.operation)
            case let .operation(url, password):
                OperationView(screen: $screen, url: url, password: password, operation: url.operation)
            }
        }
    }
}
