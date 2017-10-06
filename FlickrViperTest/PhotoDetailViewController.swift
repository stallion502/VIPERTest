//
//  PhotoDetailViewController.swift
//  FlickrViperTest
//
//  Created by Константин on 23.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerInput: class {
    func addLargeLoadedPhoto(_ photo: UIImage)
    func addPhotoImageTitle(_ title: String)
}

protocol PhotoDetailViewControllerOutput: class {
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel)
    func loadLargePhotoImage()
    func getPhotoImageTitle()
}


class PhotoDetailViewController: UIViewController, PhotoDetailViewControllerInput {
    
    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var presenter: PhotoDetailViewControllerOutput!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        PhotoDetailAssembly.sharedInstance.configure(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ask title and image from presenter
        self.presenter.getPhotoImageTitle()
        self.presenter.loadLargePhotoImage()

    }
    
    //result comes from presenter
    func addLargeLoadedPhoto(_ photo: UIImage) {
        self.photoImageView.image = photo
    }
    
    func addPhotoImageTitle(_ title: String) {
        self.photoTitleLabel.text = title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
