//
//  PhotoSearchPresenter.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

protocol PhotoSearchPresenterInput: PhotoViewControllerOutput, PhotoSearchInteractorOutput {
}

class PhotoSearchPresenter: PhotoSearchPresenterInput {
    
    weak var view: PhotoViewControllerInput!
    var interactor: PhotoSearchInteractorInput!
    var router: PhotoSearchRouterInput!
    
    //Presenter says interactor ViewController needs photos
    func fetchPhotos(_ searchtag: String, page: NSInteger) {
        
        if view.getTotalPhotoCount() == 0 {
            view.showWaitingView()
        }
        
        interactor.fetchAllPhotosFromDataManager(searchtag, page: page)
    }
    
    //Service return photos and interactor passes all data to presenter which make view display them
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger) {
        self.view.hideWaitingView()
        self.view.displayFetchedPhotos(photos, totalPages: totalPages)
    }
    
    //Show error message from service
    func serviceError(_ error: NSError) {
        self.view.displayErrorView(defaultErrorMessage)
    }
    
    func gotoPhotoDetailScreen() {
        self.router.navigateToPhotoDetail()
    }
    
    func passDataToNextScene(_ segue: UIStoryboardSegue) {
        self.router.passDataToNextScene(segue)
    }
    
}
