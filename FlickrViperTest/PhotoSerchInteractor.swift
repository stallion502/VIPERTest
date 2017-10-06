//
//  PhotoSerchInteractor.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import UIKit

protocol PhotoSearchInteractorInput: class {
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger)
}

protocol PhotoSearchInteractorOutput: class {
    func providedPhotos(_ photos: [FlickrPhotoModel], totalPages: NSInteger)
    func serviceError(_ error: NSError)
}

class PhotoSearchInteractor: PhotoSearchInteractorInput {
    
    weak var presenter: PhotoSearchInteractorOutput!
    var APIDataManager: FlickrPhotoSearchProtocol!
    
    func fetchAllPhotosFromDataManager(_ searchTag: String, page: NSInteger) {
        APIDataManager.fetchPhotosForSearchText(searchText: searchTag, page: page) { (error, totalPages, flickrPhotos) in
            if let photos = flickrPhotos {
                self.presenter.providedPhotos(photos, totalPages: totalPages)
            } else if let error = error {
                self.presenter.serviceError(error)
            }
        }
    }
    
}
