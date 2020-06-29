//
//  TaskCell.swift
//  ToDoList
//
//  Created by Анна Никифорова on 26.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit

class TaskCell: UITableViewCell {
    
    @IBOutlet weak var checkTagButton: UIButton!
    @IBOutlet weak var taskLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkTagButton.layer.cornerRadius = 15
        checkTagButton.layer.masksToBounds = true
    }
    
}
