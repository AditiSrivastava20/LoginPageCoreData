//
//  TableViewCell.swift
//  LoginPage
//
//  Created by brst on 1/12/18.
//  Copyright © 2018 loginScreen. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    static let reuseIdentifier = "tablecell"
    @IBOutlet var namelbl: UILabel!
    @IBOutlet var retrieveEmail: UILabel!
    @IBOutlet var passwordlbl: UILabel!
    @IBOutlet var phonelbl: UILabel!
    @IBOutlet var imagesStored: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
