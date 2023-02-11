//
//  DocumentSaver.swift
//  Falcon09
//
//  Created by Виктория on 08.02.2023.
//

import Foundation
import UIKit
import SwiftUI


struct DocumentSaver: UIViewControllerRepresentable {
    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var documentSaver: DocumentSaver
        
        init(_ documentSaver: DocumentSaver) {
            self.documentSaver = documentSaver
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            if let securityScopedUrl = urls.first {
                securityScopedUrl.access {
                    var array = UserDefaults.standard.array(forKey: "bookmarks") ?? []
                    if let bookmark = securityScopedUrl.bookmark {
                        array.append(bookmark)
                    }
                    UserDefaults.standard.set(array, forKey: "bookmarks")
                }
            }
        }
    }
    
    let url: URL
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forExporting: [url], asCopy: false)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator { Coordinator(self) }
}
