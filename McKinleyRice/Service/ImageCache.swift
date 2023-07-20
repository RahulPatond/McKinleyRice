//
//  ImageCache.swift
//  McKinleyRice
//
//  Created by Rahul Patond on 20/07/23.
//

import UIKit
import Foundation

actor ImageStorage {
    private var imageCache = NSCache<AnyObject, ImageCache>()
    
    func storeImageInCache(image: UIImage, urlRequest: URLRequest) async {
        let key = urlRequest.url?.absoluteString ?? ""
        let cache = ImageCache()
        cache.image = image
        imageCache.setObject(cache, forKey: key as AnyObject)
    }
    
    func retrieveCachedImage(urlRequest: URLRequest) async -> UIImage? {
        let key = urlRequest.url?.absoluteString ?? ""
        
        if let cachedVersion = imageCache.object(forKey: key as AnyObject), let cachedImage = cachedVersion.image {
            return cachedImage
            
        } else {
            return nil
        }
    }
}

class ImageCache: NSObject, NSDiscardableContent {

    public var image: UIImage!

    func beginContentAccess() -> Bool {
        return true
    }

    func endContentAccess() {
    }

    func discardContentIfPossible() {
    }

    func isContentDiscarded() -> Bool {
        return false
    }
}

