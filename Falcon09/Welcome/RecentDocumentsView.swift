//
//  RecentDocumentsView.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import SwiftUI


struct RecentDocumentsView: View {
    let parent: Welcome
    let action: (SecurityScopedUrl) -> Void
    var urls: [SecurityScopedUrl] { Array(parent.urls) as! [SecurityScopedUrl] }
    
    var body: some View {
        if urls.count > 0 {
            VStack(alignment: .leading) {
                HStack {
                    Text(NSLocalizedString("Recent documents:", comment: "Recent documents text view"))
                        .foregroundColor(Color.OFELightGray)
                    Spacer()
                    Button { parent.isPresentingClearAlert.toggle() } label: {
                        Text(NSLocalizedString("Clear", comment: "Clear recent documents list"))
                            .foregroundColor(.red)
                    }
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(urls, id: \.self) { securityScopedUrl in
                            Button { action(securityScopedUrl) } label: {
                                HStack(alignment: .firstTextBaseline) {
                                    ZStack {
                                        if securityScopedUrl.pathExtension == "crypto" {
                                            Image("encrypted-document")
                                                .resizable(resizingMode: .stretch)
                                                .scaledToFit()
                                        }
                                    }
                                    .frame(width: 20, height: 20)
                                    Text(securityScopedUrl.lastPathComponent)
                                        .foregroundColor(Color.white)
                                        .lineLimit(1)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .padding([.leading, .trailing])
            .alert(
                Text(NSLocalizedString("Clear recent documents?", comment: "Clear recent documents list alert title")),
                isPresented: parent.$isPresentingClearAlert)
            {
                Button(NSLocalizedString("Cancel", comment: "Cancel buttom text"), role: .cancel) {}
                Button(NSLocalizedString("Clear", comment: "Clear recent documents list"), role: .destructive)
                {
                    UserDefaults.standard.set([], forKey: "bookmarks")
                    parent.urls.removeAllObjects()
                    parent.refresh.toggle()
                }
            } message: {
                Text(NSLocalizedString("Clearing recent documents is irreversible", comment: "Clear recent documents list alert message"))
            }

        } else {
            EmptyView()
        }
    }
}
