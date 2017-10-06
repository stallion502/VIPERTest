//
//  PhotoDetailAssembly.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class PhotoDetailAssembly {
    
    static let sharedInstance = PhotoDetailAssembly()
    
    func configure(_ viewController: PhotoDetailViewController) {
        let APIDataManager: FlickrPhotoLoadImageProtocol = FlickrDataManager()
        let interactor = PhotoDetailInteractor()
        let presenter = PhotoDetailPresenter()
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        interactor.imageDataManager = APIDataManager
    }
    
}
