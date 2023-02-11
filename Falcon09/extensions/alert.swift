//
//  alert.swift
//  Falcon09
//
//  Created by Виктория on 11.02.2023.
//

import Foundation
import SwiftUI


extension View {
    func alert<A, M: View>(
        _ titleKey: LocalizedStringKey,
        isPresented: Binding<Bool>,
        message: () -> M
    ) -> some View {
        self.alert(titleKey, isPresented: isPresented, actions: {}, message: message)
    }
}
