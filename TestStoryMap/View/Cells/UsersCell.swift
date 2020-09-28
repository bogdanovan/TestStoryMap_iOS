//
//  UsersCell.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 23.09.2020.
//

import UIKit

class UsersCell: UITableViewCell {

    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBatteryPercentageLabel: UILabel!
    @IBOutlet weak var userBatteryImage: UIImageView!
    @IBOutlet weak var relationLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let accessoryView = UIImageView(image: UIImage(named: K.disclosureIndicatorName))
        self.accessoryView = accessoryView
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
