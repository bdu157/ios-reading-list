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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
            self.tableView.reloadData()
    }
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
/*
        if section == 0 {
            return "Read Books"
        } else {
            return "Unread Books"
        }
*/
//correct way to avoid showing section titles when there is no input of book
        if section == 0 {
            if bookController.readBooks.count == 0 {
                return nil
            } else {
                return "Read Books"
            }
        } else {
            if bookController.unreadBooks.count == 0 {
                return nil
            } else {
                return "UnRead Books"
            }
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
        /* alernative way
        switch section {
        case 0:
            return bookController.readBooks.count
        case 1:
            return bookController.unreadBooks.count
        default:
            return bookController.unreadBooks.count
        }
        */
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
        let book = bookFor(indexPath: indexPath)
        bookController.deleteBooks(book: book)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetailVCFromAdd" {
            guard let destVC = segue.destination as? BookDetailViewController else {return}
                destVC.bookController = bookController
        } else if segue.identifier == "ToDetailVCFromCell" {
            guard let destVC = segue.destination as? BookDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            let book = bookController.books[indexPath.row]
            destVC.bookController = bookController
            destVC.book = book
        }
    }
    func toggleHasbeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)    //through this, hasBeenRead bool gets changed
        self.tableView.reloadData() // through this, cellForRowAt gets triggered and this will reuse cell and show under either section 0 or section 1 depending on boolean value of hasBeenRead
    }
    private func bookFor(indexPath: IndexPath) -> Book {   //if the cell (struct) that you are trying to do with things is within section 0 then return a struct that has hasBeenRead as true
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
}
