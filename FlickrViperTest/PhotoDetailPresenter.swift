//
//  PhotoDetailPresenter.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

protocol PhotoDetailPresenterInput: PhotoDetailViewControllerOutput, PhotoDetailInteractorOutput {}

class PhotoDetailPresenter: PhotoDetailPresenterInput {
    
    weak var view: PhotoDetailViewControllerInput!
    var interactor: PhotoDetailInteractorInput!
    
    //Passing data from PhotoSearch Module Router
    func saveSelectedPhotoModel(_ photoModel: FlickrPhotoModel) {
        self.interactor.configurePhotoModel(photoModel)
    }
    
    func loadLargePhotoImage() {
        self.interactor.loadUIImageFromUrl()
    }
    
    //result comes from Interactor
    func sendLoadedPhotoImage(_ image: UIImage) {
        self.view.addLargeLoadedPhoto(image)
    }
    
    func getPhotoImageTitle() {
        let imageTitle = self.interactor.getPhotoImageTitle()
        self.view.addPhotoImageTitle(imageTitle)
    }
}
