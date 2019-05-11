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
    
    
    var readBooks: [Book] {
        let hasBeenRead = books.filter {$0.hasBeenRead == true}
        return hasBeenRead
    }
    
    var unreadBooks: [Book] {
        let hasNotBeenRead = books.filter {$0.hasBeenRead == false}   //trailing closure syntax  you can also use a func as an argument of higher order functions - sorted, filter, map, reduce - this is called callbacks
        return hasNotBeenRead
    }
    
    
    init() {}
    
    //CRUD - Create, Read, Update, Delete
    func createBooks(title: String, reasonToRead: String) {
        let input = Book.init(title: title, reasonToRead: reasonToRead)
        books.append(input)
        saveToPersistentStore()
    }
    
    func deleteBooks(book: Book) {
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStore()
    }
    
    func updateHasBeenRead(for book:Book) {
        guard let index = books.index(of: book) else {return}
            var hasBeenRead = books[index].hasBeenRead
            hasBeenRead = !hasBeenRead
            saveToPersistentStore()
    }

    func editbBooks(for book: Book, updateTitleto title: String, updateReasonToReadto reasonToRead: String) {
        guard let index = books.index(of: book) else {return}
            books[index].title = title
            books[index].reasonToRead = reasonToRead
            saveToPersistentStore()
    }
    
    
    //creating a file(location)
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return documentDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    
    //save struct to a file(location) created above
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

    //load endocded struct in the file(location) as encoded struct back to struct
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
