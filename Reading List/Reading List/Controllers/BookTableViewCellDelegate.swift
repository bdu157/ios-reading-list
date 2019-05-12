//
//  BookTableViewCellDelegate.swift
//  Reading List
//
//  Created by Dongwoo Pae on 5/11/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

protocol BookTableViewCellDelegate {
    func toggleHasbeenRead(for cell: BookTableViewCell)
}
