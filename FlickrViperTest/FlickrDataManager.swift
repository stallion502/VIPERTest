//
//  FlickrDataManager.swift
//  FlickrViperTest
//
//  Created by Константин on 24.08.16.
//  Copyright © 2016 Константин. All rights reserved.
//

import Foundation
import SDWebImage

protocol FlickrPhotoSearchProtocol: class {
    func fetchPhotosForSearchText(searchText: String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void
}

protocol FlickrPhotoLoadImageProtocol: class {
    func loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void)
}

class FlickrDataManager: FlickrPhotoSearchProtocol, FlickrPhotoLoadImageProtocol {
    
    struct Errors {
        static let invalidAccessErrorCode = 100
    }
    
    struct FlickerAPIMetadataKeys {
        static let failureStatusCode = "code"
    }
    
    struct FlickrAPI {
        static let APIKey = "2d2e1b0d53275fd4ae2158e0c0937472"
        
        static let tagsSearchFormat = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&page=%i&format=json&nojsoncallback=1"
    }
    
    func fetchPhotosForSearchText(searchText: String, page: NSInteger, closure: @escaping (NSError?, NSInteger, [FlickrPhotoModel]?) -> Void) -> Void {
        
        let escapedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let format = FlickrAPI.tagsSearchFormat
        let arguments: [CVarArg] = [FlickrAPI.APIKey, escapedSearchText!, page]
        
        let photosURL = String(format: format, arguments: arguments)
        
        let url = NSURL(string: photosURL)!
        let request = URLRequest(url: url as URL)
        
        let searchTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error fetching photos: \(error)")
                closure(error as NSError?, 0, nil)
            }
            
            do {
                
                let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                
                guard let results = resultsDictionary else { return }
                
                if let statusCode = results[FlickerAPIMetadataKeys.failureStatusCode] as? Int {
                    if statusCode == Errors.invalidAccessErrorCode {
                        let invalidAccessError = NSError(domain: "FlickrAPIDomain", code: statusCode, userInfo: nil)
                        closure(invalidAccessError, 0, nil)
                        return
                    }
                }
                
                guard let photosContainer = resultsDictionary!["photos"] as? NSDictionary else { return }
                guard let totalPageCountString = photosContainer["total"] as? String else { return }
                guard let totalPageCount = NSInteger(totalPageCountString as String) else { return }
                
                guard let photosArray = photosContainer["photo"] as? [NSDictionary] else { return }
                
                let flickrPhotos: [FlickrPhotoModel] = photosArray.map({ (photoDictionary) -> FlickrPhotoModel in
                    
                    let photoId = photoDictionary["id"] as? String ?? ""
                    let farm = photoDictionary["farm"] as? Int ?? 0
                    let secret = photoDictionary["secret"] as? String ?? ""
                    let server = photoDictionary["server"] as? String ?? ""
                    let title = photoDictionary["title"] as? String ?? ""
                    
                    let flickrPhoto = FlickrPhotoModel(photoId: photoId, farm: farm, secret: secret, server: server, title: title)
                    
                    return flickrPhoto
                    
                })
                
                closure(nil, totalPageCount, flickrPhotos)
                
                
            } catch let error as NSError {
                print("Error parsing JSON: \(error)")
                closure(error, 0, nil)
                return
            }
        }
        searchTask.resume()
    }
    
    //Memory Cache Photo services
    func loadImageFromUrl(_ url: NSURL, closure: @escaping (UIImage?, NSError?) -> Void) {
        SDWebImageManager.shared().downloadImage(with: url as URL!, options: .cacheMemoryOnly, progress: nil) { (image, error, cache, finished, withUrl) in
            if ((image != nil) && finished) {
                closure(image, error as NSError?)
            }
        }
    }
    
    
    
}
