//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Dongwoo Pae on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    

    
    let bookController = BookController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            let readBooks = bookController.readBooks
            return readBooks.count
        } else if section == 1 {
            let unreadBooks = bookController.unreadBooks
            return unreadBooks.count
        }
        return bookController.books.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        guard let bookTableViewCell = cell as? BookTableViewCell else {return cell}
            let book = bookFor(indexPath: indexPath)     //this will determine which section this cell should be reused
            bookTableViewCell.book = book
            bookTableViewCell.delegate = self
            return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let book = bookController.books[indexPath.row]
        bookController.deleteBooks(book: book)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
    }
    
    func toggleHasbeenRead(for cell: BookTableViewCell) {
        guard let updateCell = cell.book else {return}
        bookController.updateHasBeenRead(for: updateCell)
        self.tableView.reloadData()
    }

    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
}
