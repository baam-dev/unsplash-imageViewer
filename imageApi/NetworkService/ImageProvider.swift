//
//  ImageProvider.swift
//  imageApi
//
//  Created by Amir Bakhshi on 2022-03-18.
//

import Foundation
import UIKit

class ImageProvider {
    static let instance = ImageProvider()
    
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    public func fetchImage(url: String, completion: @escaping (UIImage?) -> Void) {
        if let image = cache.object(forKey: url as NSString) {
//            print("From cache ...")
            completion(image)
            return
        }
        
        guard let urlString = URL(string: url) else { return }
//        print("Fetching image ...")
        let task = URLSession.shared.dataTask(with: urlString, completionHandler: { [weak self] data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                guard let image = UIImage(data: data) else {
                    completion(nil)
                    return
                }
                // Caching
                self?.cache.setObject(image, forKey: url as NSString)
                completion(image)
            }
        })
        task.resume()
    }
}
