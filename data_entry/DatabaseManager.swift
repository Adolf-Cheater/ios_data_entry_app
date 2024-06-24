//
//  DatabaseManager.swift
//  data_entry
//
//  Created by Richie Chenyuqi on 2024-06-24.
//
import Foundation
import SQLite

struct DatabaseManager {
    private var db: Connection?

    init() {
        do {
            let path = NSSearchPathForDirectoriesInDomains(
                .documentDirectory, .userDomainMask, true
            ).first!
            db = try Connection("\(path)/db.sqlite3")
            createTable()
        } catch {
            print("Unable to initialize database: \(error)")
        }
    }

    private func createTable() {
        let entries = Table("entries")
        let id = Expression<Int64>("id")
        let userName = Expression<String>("userName")
        let description = Expression<String>("description")
        let value = Expression<String>("value")
        let timestamp = Expression<String>("timestamp")

        do {
            try db?.run(entries.create { t in
                t.column(id, primaryKey: true)
                t.column(userName)
                t.column(description)
                t.column(value)
                t.column(timestamp)
            })
        } catch {
            print("Failed to create table: \(error)")
        }
    }

    func saveEntry(_ entry: Entry) {
        let entries = Table("entries")
        let userName = Expression<String>("userName")
        let description = Expression<String>("description")
        let value = Expression<String>("value")
        let timestamp = Expression<String>("timestamp")

        let insert = entries.insert(
            userName <- entry.userName,
            description <- entry.items.first?.description ?? "",
            value <- entry.items.first?.value ?? "",
            timestamp <- entry.timestamp
        )
        do {
            try db?.run(insert)
        } catch {
            print("Failed to insert entry: \(error)")
        }
    }

    
    //LOCAL IMPLEMENTATION - USEAGE SHOWN BELOW
    func fetchEntries() -> [Entry] {
        var entriesArray = [Entry]()
        let entriesTable = Table("entries")
        let userName = Expression<String>("userName")
        let description = Expression<String>("description")
        let value = Expression<String>("value")
        let timestamp = Expression<String>("timestamp")

        do {
            for entry in try db!.prepare(entriesTable) {
                let itemTuple: (description: String, value: String) = (description: entry[description], value: entry[value])
                let items = [itemTuple]
                let entryModel = Entry(
                    userName: entry[userName],
                    items: items,
                    timestamp: entry[timestamp]
                )
                entriesArray.append(entryModel)
            }
        } catch {
            print("Failed to fetch entries: \(error)")
        }
        return entriesArray
    }
}

/*
 func fetchEntries() {
     guard let url = URL(string: "https://api.yourdomain.com/entries") else { return }

     URLSession.shared.dataTask(with: url) { data, response, error in
         guard let data = data else {
             print("No data returned from server \(error?.localizedDescription ?? "Unknown error")")
             return
         }
         if let response = try? JSONDecoder().decode([Entry].self, from: data) {
             DispatchQueue.main.async {
                 self.entries = response
             }
         }
     }.resume()
 }
 */
