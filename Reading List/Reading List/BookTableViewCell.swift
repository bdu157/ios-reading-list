//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Dongwoo Pae on 5/10/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation
import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    var delegate : BookTableViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func checkButtonTapped(_ sender: Any) {
        self.delegate?.toggleHasbeenRead(for: self)
    }
    
    
    func updateViews() {
        guard let bookTitle = book?.title,
            let bookHasBeeRead = book?.hasBeenRead else {return}
        bookTitleLabel.text = bookTitle
        
        if bookHasBeeRead {
            checkButton.setImage(UIImage(named:"checked"), for: .normal)
        } else {
            checkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
}
