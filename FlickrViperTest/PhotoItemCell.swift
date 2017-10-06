//
//  PhotoItemCell.swift
//  FlickrViperTest
//
//  Created by Константин on 25.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class PhotoItemCell: UICollectionViewCell, ReuseIdentifierProtocol {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
    }
}
