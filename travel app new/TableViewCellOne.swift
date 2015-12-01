//
//  TableViewCellOne.swift
//  travel app new
//
//  Created by ashraf ul alam tusher on 11/27/15.
//  Copyright © 2015 tusher. All rights reserved.
//

import UIKit

class TableViewCellOne: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNameTwo: UILabel!
    @IBOutlet weak var txtMany: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var stepper: UIStepper!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
