//
//  CacheImageView.swift
//  TV Shows
//
//  Created by Ali Hassan on 10/02/2021.
//

import UIKit

class CacheImageView: UIImageView {
    
    // MARK: - Constants
    
    private let imageCache = NSCache<NSString, AnyObject>()
    
    // MARK: - Properties
    
    private var imageURLString: String?
    private var dataTask: URLSessionDataTask?
    
    func downloadImageFrom(urlString: String) {
        self.imageURLString = urlString
        downloadImage(urlString: urlString)
    }
    
    private func downloadImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        self.dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                  let data = data, error == nil,
                  let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                if self.imageURLString == urlString {
                    self.image = image
                }
                
                self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            }
        }
        
        dataTask?.resume()
    }
    
    func cancelLoadingImage() {
        dataTask?.cancel()
        dataTask = nil
    }
}
