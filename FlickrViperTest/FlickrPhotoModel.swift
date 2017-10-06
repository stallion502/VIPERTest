//
//  FlickrPhotoModel.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import Foundation


struct FlickrPhotoModel {
    let photoId: String
    let farm: Int
    let secret: String
    let server: String
    let title: String
    
    var photoUrl: NSURL {
        return flickrImageURL()
    }
    
    var largePhotoUrl: NSURL {
        return flickrImageURL(size: "b")
    }
    
    private func flickrImageURL(size: String = "m") -> NSURL {
        return NSURL(string: "https://farm\(farm).staticflickr.com/\(server)/\(photoId)_\(secret)_\(size).jpg")!
    }
}
