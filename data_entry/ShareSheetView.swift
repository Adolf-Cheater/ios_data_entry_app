//
//  ShareSheetView.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-19.
//
//.background(Color(red: 0, green: 0.09228330106, blue: 0.351700902, opacity: 1))
import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    var url: URL

    func makeUIViewController(context: Context) -> UIActivityViewController {
        if FileManager.default.fileExists(atPath: url.path) {
            let controller = UIActivityViewController(activityItems: [url], applicationActivities: nil)
            return controller
        } else {
            print("File does not exist at the path: \(url.path)")
            return UIActivityViewController(activityItems: [], applicationActivities: nil)
        }
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update action needed
    }
}
