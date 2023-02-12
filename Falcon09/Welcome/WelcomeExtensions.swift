//
//  WelcomeExtensions.swift
//  Falcon09
//
//  Created by Виктория on 12.02.2023.
//

import Foundation
import SwiftUI


extension Welcome {
    func updateRecentDocumentsList() {
        DispatchQueue.global(priority: .default).async {
            var needsDisplay = false
            for bookmark in bookmarks ?? [] {
                if let securityScopedUrl = bookmark.resolve() {
                    // if url is not a placeholder and hasn't been added to the list yet
                    if securityScopedUrl.fileExists && !urls.contains(securityScopedUrl) {
                        urls.add(securityScopedUrl)
                        needsDisplay = true
                    }
                }
            }
            if needsDisplay { refresh.toggle() }
        }
    }
    
    func switchScreen() {
        if screen == .welcome {
            url.generateThumbnail(CGSizeMake(200, 200)) { thumbnail.image = $0 }
            DispatchQueue.global(priority: .high).asyncAfter(deadline: .now() + .milliseconds(1250)) {
                screen = .password(url)
            }
        }
    }
}
