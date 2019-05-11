//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Dongwoo Pae on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    
    @IBOutlet weak var reasontoReadTextview: UITextView!
    
    @IBOutlet weak var bookDetailVCTitle: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let titleInput = bookTitleTextField.text,
            let reasonToReadInput = reasontoReadTextview.text else {return}
        if book == nil {    //if let book = book here would not work because you will not need to use book constant inside of closure
            bookController?.createBooks(title: titleInput, reasonToRead: reasonToReadInput)
        } else {
            guard let book = book else {return}
            bookController?.editbBooks(for: book, updateTitleto: titleInput, updateReasonToReadto: reasonToReadInput)
        }
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews() {
        guard let book = book else {return}
            let bookTitle = book.title
            let reasonToRead = book.reasonToRead
            bookTitleTextField.text = bookTitle
            reasontoReadTextview.text = reasonToRead
            bookDetailVCTitle.title = bookTitle
    }
    
}
