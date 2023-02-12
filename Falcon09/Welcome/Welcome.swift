//
//  Welcome.swift
//  Falcon09
//
//  Created by Виктория on 07.02.2023.
//

import SwiftUI
import UIKit


struct Welcome: View {
    @Binding var screen: Screen
    let thumbnail: OFEThumbnail
    
    @State var url: AnyOFEUrl!
    @State var isPresenting: Bool = false
    @State var refresh = false
    let urls = NSMutableSet()
    
    var bookmarks: [Data]? {
        return UserDefaults.standard.array(forKey: "bookmarks") as? [Data]
    }
    
    var body: some View {
        print("Welcome body")
        
        let font = UIFont.boldSystemFont(ofSize: 36)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]
        let width1 = sum(.Open, .File, withAttributes: attributes) + 20
        let width2 = sum(.Encryptor, withAttributes: attributes)
        
        return Background {
            if refresh {}
            
            GeometryReader { proxy in
                let width = proxy.size.width
                let isFit = (width - width1 - 20) >= width2
                VStack {
                    HStack(spacing: 20) {
                        Text(String(.Open))
                            .font(Font(font as CTFont))
                        Text(String(.File))
                            .font(Font(font as CTFont))
                        if isFit {
                            Text(String(.Encryptor))
                                .font(Font(font as CTFont))
                        }
                    }
                    if !isFit {
                        Text(String(.Encryptor))
                            .font(Font(font as CTFont))
                    }
                    HStack { Spacer() }
                }
            }
            
            VStack(spacing: 20) {
                Button { isPresenting.toggle() } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color.OFEYellow)
                            .frame(height: 150)
                            .scaleEffect(y: url == nil ? 1 : 0.46, anchor: .top)
                            .animation(.linear(duration: 1.25), value: url)
                        Image("arrow")
                            .resizable()
                            .scaledToFit()
                            .padding([.top, .bottom])
                            .frame(height: 150)
                            .scaleEffect(url == nil ? 1 : 0.46, anchor: .top)
                            .animation(.linear(duration: 1.25), value: url)
                    }
                }
                
                Text(NSLocalizedString("Press to start", comment: "Text under the arrow"))
                
                RecentDocumentsView(self) { url = AnyOFEUrl($0) }
                    .padding([.top], 20)
            }
            .offset(y: 200)
        }
        .foregroundStyle(Color.white)
        .sheet(isPresented: $isPresenting) {
            DocumentPicker(url: $url)
        }
        .onChange(of: url) { _ in switchScreen() }
        .onAppear { updateRecentDocumentsList() }
    }
    
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome(screen: .constant(.welcome), thumbnail: OFEThumbnail())
    }
}
