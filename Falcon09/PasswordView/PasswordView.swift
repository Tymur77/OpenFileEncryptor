//
//  PasswordView.swift
//  Falcon09
//
//  Created by Виктория on 09.02.2023.
//

import SwiftUI

struct PasswordView: View {
    @Binding var screen: Screen
    let thumbnail: OFEThumbnail
    let url: AnyOFEUrl
    let operation: CryptoOperation
    
    @State var password: String = ""
    
    var body: some View {
        print("PasswordView body")
        
        var size: String
        if let bytes = url.size {
            size = String(Size(bytes: UInt64(bytes)))
        } else {
            size = NSLocalizedString("Unknown size", comment: "Unknown file size")
        }
        
        let operationString = operation == .encrypt ? NSLocalizedString("Encrypt", comment: "Encrypt") : NSLocalizedString("Decrypt", comment: "Decrypt")
        
        return Background {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(String(.all))
                    Spacer()
                }
                YellowButton(NSLocalizedString("Back", comment: "Go back button")) { screen = .welcome }
                    .padding([.leading])
            }
            
            PasswordBar(password: $password)
                .offset(y: 200)
            
            VStack() {
                thumbnail.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text(url.lastPathComponent)
                    .padding([.leading, .trailing])
                    .lineLimit(1)
                Text(size)
                    .foregroundColor(Color.OFELightGray)
                GeometryReader { proxy in
                    if password.count > 0 {
                        YellowButton(operationString, proxy.size.width/2) {
                            screen = .operation(url, password)
                        }
                        .position(x: proxy.center.x)
                    }
                }
                .offset(y: 20)
            }
            .offset(y: 300)
        }
        .foregroundStyle(Color.white)
    }
    
}
