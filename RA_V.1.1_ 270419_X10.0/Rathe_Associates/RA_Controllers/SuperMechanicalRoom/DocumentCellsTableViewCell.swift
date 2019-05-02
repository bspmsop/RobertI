//
//  DocumentCellsTableViewCell.swift
//  Rathe_Associates
//
//  Created by apple on 13/11/18.
//  Copyright © 2018 zonupTechnologies. All rights reserved.
//

import UIKit

class DocumentCellsTableViewCell: UITableViewCell {
    @IBOutlet var documentTitle: UILabel!
    @IBOutlet weak var btnwt: NSLayoutConstraint!
    @IBOutlet var documentName: UIButton!
    @IBOutlet weak var delteDocBtn: UIBotton!
    @IBOutlet var documentDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
