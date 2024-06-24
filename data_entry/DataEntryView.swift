//
//  DataEntryView.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-19.
//
import SwiftUI

struct DataEntryView: View {
    @Binding var entries: [Entry]
    @State private var userName = ""
    @State private var pairs: [(description: String, value: String)] = []
    @State private var showAlert = false  // State for showing validation errors
    @State private var alertMessage = "Numerical value when entering values, else it will not register"  // Message for the alert
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Name")) {
                    TextField("Enter user name", text: $userName)
                }
                
                Section(header: Text("Add Data")) {
                    ForEach($pairs.indices, id: \.self) { index in
                        HStack {
                            TextField("Description", text: $pairs[index].description)
                            TextField("Value", text: $pairs[index].value, onCommit: {
                                // Validate on commit instead of every change
                                ensureNumericValue(index: index)
                            })
                            .keyboardType(.decimalPad)  // Suggests numerical input
                        }
                    }
                    Button("Add More") {
                        pairs.append((description: "", value: ""))
                    }
                }
                
                Button("Save Data") {
                    saveData()
                }
            }
            .navigationBarTitle("Data Entry")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Reminder"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func saveData() {
        if pairs.allSatisfy({ Double($0.value) != nil }) {
            let currentTimestamp = Date().formatted(date: .numeric, time: .shortened)
            let newEntry = Entry(userName: userName, items: pairs, timestamp: currentTimestamp)
            entries.append(newEntry)
            // Optionally dismiss the view
            presentationMode.wrappedValue.dismiss()
        } else {
            alertMessage = "All values must be numerical to save."
            showAlert = true
        }
    }
    
    private func ensureNumericValue(index: Int) {
        if let _ = Double(pairs[index].value) {
            // Valid numeric input, do nothing
        } else if !pairs[index].value.isEmpty {
            // Non-numeric input detected, clear and show alert
            pairs[index].value = ""
            alertMessage = "Only numerical values are allowed."
            showAlert = true
        }
    }
}

// Assuming Entry is correctly defined elsewhere in your code
