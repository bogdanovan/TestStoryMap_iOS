//
//  PlacesCell.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import UIKit

class PlacesCell: UITableViewCell {

    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
