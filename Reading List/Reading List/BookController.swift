//
//  BookController.swift
//  Reading List
//
//  Created by Dongwoo Pae on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    
    var books: [Book] = []
    
    
    
    init() {}
    
    
    
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    
    func saveToPersistentStore() {
        guard let url = readingListURL else {return}
    do {
        let encoder = PropertyListEncoder()
        let booksData = try encoder.encode(url)
        try booksData.write(to: url)
    } catch {
        NSLog("error saving books data: \(error)")
        }
    }

    func loadFromPersistentStore() {
            let fileManager = FileManager.default
        guard let url = readingListURL,
            fileManager.fileExists(atPath: url.path) else {return}
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodeBooks = try decoder.decode([Book].self, from: data)
            self.books = decodeBooks
        } catch {
            NSLog("error loding books data: \(error)")
        }
        
    }

}
