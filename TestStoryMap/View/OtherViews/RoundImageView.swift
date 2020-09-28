//
//  RoundImage.swift
//  TestStoryMap
//
//  Created by Anatolii Bogdanov on 24.09.2020.
//

import UIKit

class RoundImageView: UIImageView {

    override init(image: UIImage?) {
            super.init(image: image)
        }

        override init(frame: CGRect) {
            super.init(frame: frame)
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }

        override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.cornerRadius = self.frame.size.height / 2
            self.clipsToBounds = true
        }

}
