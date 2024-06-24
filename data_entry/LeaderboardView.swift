//
//  LeaderboardView.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-20.
//

import SwiftUI

struct LeaderboardView: View {
    var entries: [Entry]
    @State private var selectedUser: UserTotal?

    var body: some View {
        List(sortedUsers(by: entries).enumerated().map({ $0 }), id: \.element.id) { index, user in
            Button(action: {
                selectedUser = user
            }) {
                HStack {
                    Text("\(index + 1). \(user.name)")
                        .bold()
                    Spacer()
                    Text(String(format: "%.2f", user.total))
                }
            }
        }
        .navigationBarTitle("Leaderboard")
        .sheet(item: $selectedUser) { user in
            NavigationView {
                List {
                    ForEach(user.entries, id: \.id) { entry in
                        Section(header: Text(entry.userName)) {
                            ForEach(entry.items, id: \.description) { item in
                                HStack {
                                    Text(item.description)
                                    Spacer()
                                    Text(item.value)
                                }
                            }
                        }
                    }
                }
                .navigationBarTitle("Details", displayMode: .inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Close") {
                            selectedUser = nil
                        }
                    }
                }
            }
        }
    }

    func sortedUsers(by entries: [Entry]) -> [UserTotal] {
        var totals: [String: (total: Double, entries: [Entry])] = [:]
        
        for entry in entries {
            let sum = entry.items.reduce(0) { $0 + (Double($1.value) ?? 0) }
            if totals[entry.userName] == nil {
                totals[entry.userName] = (sum, [entry])
            } else {
                totals[entry.userName]?.total += sum
                totals[entry.userName]?.entries.append(entry)
            }
        }
        
        return totals.map { UserTotal(name: $0.key, total: $0.value.total, entries: $0.value.entries) }
                     .sorted { $0.total > $1.total }
    }
}
struct UserTotal: Identifiable {
    let id = UUID()
    var name: String
    var total: Double
    var entries: [Entry]
}
