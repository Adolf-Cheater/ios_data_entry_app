//
//  DataView.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-19.
//

import SwiftUI


struct DataView: View {
    var entries: [Entry]
    @State private var selectedEntry: Entry?

    var body: some View {
        NavigationView {
            List(entries) { entry in
                VStack(alignment: .leading) {
                    Button(action: {
                        if selectedEntry?.id == entry.id {
                            selectedEntry = nil // Collapse if the same entry is tapped again
                        } else {
                            selectedEntry = entry // Expand to show details
                        }
                    }) {
                        HStack {
                            Text(entry.userName)
                                .font(.headline)
                            Spacer()
                            Text(entry.timestamp)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    if selectedEntry?.id == entry.id {
                        ForEach(entry.items.indices, id: \.self) { index in
                            VStack(alignment: .leading) {
                                Text("Description: \(entry.items[index].description)")
                                    .padding(.top)
                                Text("Value: \(entry.items[index].value)")
                            }
                            .padding(.leading)
                        }
                        .transition(.slide)
                        .animation(.default)
                    }
                }
            }
            .navigationBarTitle("Saved Data")
        }
    }
}


/*
struct DataView: View {
    var entries: [Entry]
    @State private var selectedEntry: Entry?
    @State private var showShareSheet = false
    @State private var pdfURL: URL?

    var body: some View {
        List {
            ForEach(entries) { entry in
                Button(action: {
                    selectedEntry = entry
                    if let url = createPDF(for: entry) {
                        pdfURL = url
                        showShareSheet = true
                    }
                }) {
                    HStack {
                        Text(entry.userName)
                        Spacer()
                        Text(entry.timestamp)
                    }
                }
            }
        }
        .navigationBarTitle("Saved Data")
        .sheet(isPresented: $showShareSheet) {
            if let url = pdfURL {
                ShareSheet(url: url)
            } else {
                Text("Failed to create PDF file.")
            }
        }
    }

    func createPDF(for entry: Entry) -> URL? {
        let pdfMetaData = [
            kCGPDFContextCreator: "Data Entry App",
            kCGPDFContextAuthor: "app.author"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]

        let pageWidth = 612
        let pageHeight = 792
        let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect, format: format)

        let data = renderer.pdfData { context in
            context.beginPage()
            let titleAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
            let textAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)]
            
            let title = "User: \(entry.userName)"
            title.draw(at: CGPoint(x: 20, y: 20), withAttributes: titleAttributes)
            
            let date = "Date: \(entry.timestamp)"
            date.draw(at: CGPoint(x: pageWidth - 150, y: 20), withAttributes: textAttributes)

            var yPos = 50
            for (index, item) in entry.items.enumerated() {
                let text = "\(index + 1). \(item.description): \(item.value)"
                text.draw(at: CGPoint(x: 20, y: yPos), withAttributes: textAttributes)
                yPos += 20
            }
        }

        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("DataEntry.pdf")
        print("PDF URL: \(fileURL)")
        try? data.write(to: fileURL)

   

        return fileURL
    }
}
*/


