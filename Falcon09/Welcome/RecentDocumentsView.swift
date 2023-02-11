//
//  RecentDocumentsView.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import SwiftUI

struct RecentDocumentsView: View {
    let parent: Welcome
    let action: (URL) -> Void
    var urls: [URL] { Array(parent.urls) as! [URL] }
    
    init(_ parent: Welcome, _ action: @escaping (URL) -> Void) {
        self.parent = parent
        self.action = action
    }
    
    var body: some View {
        if urls.count > 0 {
            VStack(alignment: .leading) {
                HStack {
                    Text(NSLocalizedString("Recent documents:", comment: "Recent documents text view"))
                        .foregroundColor(Color.OFELightGray)
                    Spacer()
                    Button {
                        UserDefaults.standard.set([], forKey: "bookmarks")
                        parent.urls.removeAllObjects()
                        parent.refresh.toggle()
                    } label: {
                        Text(NSLocalizedString("Clear", comment: "Clear recent documents list"))
                            .foregroundColor(.red)
                    }
                }
                ScrollView {
                    VStack(alignment: .leading) {
                        ForEach(urls, id: \.self) { securityScopedUrl in
                            Button { action(securityScopedUrl) } label: {
                                Text(securityScopedUrl.lastPathComponent)
                                    .foregroundColor(Color.white)
                                    .lineLimit(1)
                            }
                        }
                    }
                }
            }
            .padding([.leading, .trailing])
        } else {
            EmptyView()
        }
    }
}

struct RecentDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        RecentDocumentsView(Welcome(screen: .constant(.welcome), thumbnail: OFEThumbnail())) { _ in }
    }
}
