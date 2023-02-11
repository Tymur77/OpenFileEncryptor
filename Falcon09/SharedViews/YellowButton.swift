//
//  YellowButton.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import SwiftUI

struct YellowButton: View {
    let text: String
    let action: () -> Void
    let width: CGFloat?
    
    init(_ text: String, _ action: @escaping () -> Void = {}) {
        self.text = text
        self.action = action
        self.width = nil
    }
    
    init(_ text: String, _ width: CGFloat, _ action: @escaping () -> Void = {}) {
        self.text = text
        self.action = action
        self.width = width
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .foregroundColor(.black)
                .padding(8)
                .lineLimit(1)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(Color.OFEYellow)
                        .frame(width: self.width)
                        .shadow(radius: 5)
                }
        }
    }
}

struct YellowButton_Previews: PreviewProvider {
    static var previews: some View {
        YellowButton("Press")
    }
}
