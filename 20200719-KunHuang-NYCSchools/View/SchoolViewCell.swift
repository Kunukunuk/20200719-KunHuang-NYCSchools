//
//  SchoolViewCell.swift
//  20200719-KunHuang-NYCSchools
//
//  Created by Kun Huang on 7/19/20.
//  Copyright © 2020 Kun Huang. All rights reserved.
//

import UIKit

class SchoolViewCell: UITableViewCell {

    @IBOutlet weak var schoolName: UILabel!

    var school: School? {
        didSet {
            schoolName.text = school?.schoolName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
