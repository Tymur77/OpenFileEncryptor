//
//  DocumentPicker.swift
//  Falcon09
//
//  Created by Виктория on 07.02.2023.
//

import Foundation
import UIKit
import SwiftUI


struct DocumentPicker: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var documentPicker: DocumentPicker
        
        init(_ documentPicker: DocumentPicker) {
            self.documentPicker = documentPicker
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let securityScopedUrl = urls.first?.securityScopedWrapper {
                var array = UserDefaults.standard.array(forKey: "bookmarks") ?? []
                if let bookmark = securityScopedUrl.bookmark {
                    array.append(bookmark)
                }
                UserDefaults.standard.set(array, forKey: "bookmarks")
                documentPicker.url = AnyOFEUrl(securityScopedUrl)
            }
        }
    }
    
    @Binding var url: AnyOFEUrl!
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.init("public.data")!], asCopy: false)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
}
