//
//  Background.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import SwiftUI


struct Background<Content: View>: View {
    private let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.OFEDarkBlue
                .ignoresSafeArea()
            content
        }
    }
    
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background {}
    }
}
