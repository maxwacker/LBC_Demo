//
//  ImageDataStore.swift
//  ProductListScene
//
//  Created by maxime wacker on 30/03/2021.
//

import Foundation

final class ImageDataStore {
    private let cachedImageData = NSCache<NSURL, NSData>()
    private var loadingResponses = [NSURL: [(NSData?) -> Swift.Void]]()

    
    final func load(url: NSURL, completion: @escaping (NSData?) -> Swift.Void) {
        // Check for a cached image.
        if let cachedImageData = cachedImageData.object(forKey: url) {
                completion(cachedImageData)
            }
            return
        // In case there are more than one requestor for the image, we append their completion block.
        if loadingResponses[url] != nil {
            loadingResponses[url]?.append(completion)
            return
        } else {
            loadingResponses[url] = [completion]
        }
        // Go fetch the image.
/*
        ImageURLProtocol.urlSession().dataTask(with: url as URL) { (data, response, error) in
            // Check for the error, then data and try to create the image.
            guard let responseData = data,
                let blocks = self.loadingResponses[url], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            // Cache the image.
            self.cachedImages.setObject(responseData, forKey: url, cost: responseData.count)
            // Iterate over each requestor for the image and pass it back.
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
                return
            }
        }.resume()
 */
    }
}
