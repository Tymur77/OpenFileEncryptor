//
//  ContentView.swift
//  Falcon09
//
//  Created by Виктория on 03.02.2023.
//

import SwiftUI
import Combine


struct PasswordBar: View {
    @Binding var password: String
    @State private var isPlane: Bool = false
    
    var body: some View {
        let hideString = NSLocalizedString("Hide", comment: "Hide")
        let revealString = NSLocalizedString("Reveal", comment: "Reveal")
        let placeholder = NSLocalizedString("Password", comment: "Password text field placeholder")
        
        return HStack {
            YellowButton(isPlane ? hideString : revealString)
                .hidden()
            if isPlane {
                TextField(placeholder, text: $password)
            } else {
                SecureField(placeholder, text: $password)
            }
            YellowButton(isPlane ? hideString : revealString) { isPlane.toggle() }
        }
        .padding([.leading, .trailing])
        .frame(height: 70)
        .background(Color.OFEYellow)
        .foregroundStyle(Color.black)
        .multilineTextAlignment(.center)
    }
    
}

struct PasswordBar_Previews: PreviewProvider {
    static var previews: some View {
        PasswordBar(password: .constant(""))
    }
}
