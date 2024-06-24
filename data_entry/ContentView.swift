//
//  ContentView.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-19.
//
import SwiftUI

struct ContentView: View {
    @State private var entries: [Entry] = []
    @State private var showOptions = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DataEntryView(entries: $entries)) {
                    HStack {
                        Text("Enter your data here")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(5)
                .foregroundColor(.white)

                NavigationLink(destination: DataView(entries: entries)) {
                    HStack {
                        Text("View Saved Data")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.green)
                .cornerRadius(5)
                .foregroundColor(.white)

                NavigationLink(destination: LeaderboardView(entries: entries)) {
                    HStack {
                        Text("View Leaderboard")
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.red)
                .cornerRadius(5)
                .foregroundColor(.white)
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Main Page")
            .navigationBarItems(trailing: Button(action: {
                showOptions = true
            }) {
                Image(systemName: "ellipsis.circle")
            })
            .actionSheet(isPresented: $showOptions) {
                ActionSheet(title: Text("More Options"), message: Text("Select an option"), buttons: [
                    .default(Text("App Version")) {
                        alertMessage = "App under alpha development."
                        showAlert = true
                    },
                    .cancel()
                ])
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("App Version"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#Preview {
    ContentView()
}
