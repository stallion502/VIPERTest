//
//  PhotoSearchAssembly.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

class PhotoSearchAssembly {
    
    static let sharedInstance = PhotoSearchAssembly()
    
    func configure(_ viewController: PhotoViewController) {
        let APIDataManager: FlickrPhotoSearchProtocol = FlickrDataManager()
        let interactor = PhotoSearchInteractor()
        let presenter = PhotoSearchPresenter()
        let router = PhotoSearchRouting()
        router.viewController = viewController
        presenter.router = router
        viewController.presenter = presenter
        presenter.view = viewController
        interactor.presenter = presenter
        presenter.interactor = interactor
        interactor.APIDataManager = APIDataManager
    }
    
}
