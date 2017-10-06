//
//  PhotoDetailInteractor.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

protocol PhotoDetailInteractorOutput: class {
    func sendLoadedPhotoImage(_ image: UIImage)
}

protocol PhotoDetailInteractorInput: class {
    func configurePhotoModel(_ photoModel: FlickrPhotoModel)
    func loadUIImageFromUrl()
    func getPhotoImageTitle() -> String
}

class PhotoDetailInteractor: PhotoDetailInteractorInput {
    
    weak var presenter: PhotoDetailInteractorOutput!
    var photoModel: FlickrPhotoModel?
    var imageDataManager: FlickrPhotoLoadImageProtocol!
    
    func configurePhotoModel(_ photoModel: FlickrPhotoModel) {
        self.photoModel = photoModel
    }
    
    func loadUIImageFromUrl() {
        imageDataManager.loadImageFromUrl(self.photoModel!.largePhotoUrl) { (image, error) in
            if let image = image {
                self.presenter.sendLoadedPhotoImage(image)
            }
        }
    }
    
    func getPhotoImageTitle() -> String {
        if let title = self.photoModel?.title {
            return title
        }
        return ""
    }
}
