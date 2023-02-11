//
//  OperationView.swift
//  Falcon09
//
//  Created by Виктория on 10.02.2023.
//

import SwiftUI


struct OperationView: View {
    class OutputUrl {
        var url: URL!
    }
    class OperationError {
        var error: Error!
    }
    
    @Binding var screen: Screen
    let url: URL
    let password: String
    let operation: CryptoOperation
    let resourceType: ResourceType
    
    @State var animate = false
    @State var isPresentingAlert = false
    @State private var isPresentingSaver = false
    let outUrl = OutputUrl()
    var error = OperationError()
    
    var body: some View {
        print("OperationView body")
        
        let image = UIImage(named: "net1")!
        let ratio = image.size.width * 2 / image.size.height
        
        let scaler: CGFloat = 0.5
        let start: CGFloat = (operation == .encrypt ? -58 : -28) * scaler
        let end: CGFloat   = (operation == .encrypt ? -28 : -58) * scaler
        
        return Background {
            VStack {
                ZStack {
                    HStack {
                        Image("net2")
                            .resizable()
                            .rotationEffect(.degrees(-180))
                            .scaledToFit()
                        Image("net1")
                            .resizable()
                            .rotationEffect(.degrees(-180))
                            .scaledToFit()
                    }
                    Rectangle()
                        .fill(Color.OFEDarkBlue)
                        .aspectRatio(ratio, contentMode: .fit)
                        .scaleEffect(y: animate ? 0 : 1, anchor: .bottom)
                        .animation(animate ? .easeInOut(duration: 3.0).repeatForever(autoreverses: false) : .linear(duration: 0.0), value: animate)
                }
                Spacer()
                ZStack {
                    HStack {
                        Image("net1")
                            .resizable()
                            .scaledToFit()
                        Image("net2")
                            .resizable()
                            .scaledToFit()
                    }
                    Rectangle()
                        .fill(Color.OFEDarkBlue)
                        .aspectRatio(ratio, contentMode: .fit)
                        .scaleEffect(y: animate ? 0 : 1, anchor: .top)
                        .animation(animate ? .easeInOut(duration: 3.0).repeatForever(autoreverses: false) : .linear(duration: 0.0), value: animate)
                }
            }
            .ignoresSafeArea()
            .overlay {
                Image("lock")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160 * scaler, height: 121 * scaler)
                    .offset(y: 60.5 * scaler)
                Image("handle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 160 * scaler, height: 116 * scaler)
                    .offset(y: animate ? start : end)
                    .animation(animate ? .linear(duration: 0.0) : .linear(duration: 0.5), value: animate)
                GeometryReader { proxy in
                    VStack(spacing: 20) {
                        YellowButton(NSLocalizedString("Save", comment: "Save button"), proxy.size.width/2) {
                            isPresentingSaver.toggle()
                        }
                        YellowButton(NSLocalizedString("Restart", comment: "Restart button"), proxy.size.width/2) {
                            screen = .welcome
                        }
                    }
                    .position(x: proxy.center.x, y: proxy.center.y + 150)
                    .opacity(animate ? 0 : 1)
                    .animation(animate ? .linear(duration: 0.0) : .linear.delay(0.75), value: animate)
                }
            }
            HStack {
                Spacer()
                Text(String(.all))
                Spacer()
            }
            .opacity(animate ? 0 : 1)
            .animation(.linear, value: animate)
        }
        .onAppear {
            animate = true
            main()
        }
        .alert("Operation failed alert title", isPresented: $isPresentingAlert) {
            Button(NSLocalizedString("Restart", comment: "Restart button")) {
                screen = .welcome
            }
        } message: {
            Text(error.error?.localizedDescription ?? NSLocalizedString("Unknown Error", comment: "Unknown Error alert message"))
        }
        .sheet(isPresented: $isPresentingSaver) {
            DocumentSaver(url: outUrl.url)
        }
        .foregroundStyle(Color.white)

    }
    
}

struct OperationView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(string: "https://developer.apple.com/")!
        let password = "Password1"
        return OperationView(screen: .constant(.operation(url, password, .imported)), url: url, password: password, operation: url.operation, resourceType: .imported)
    }
}
