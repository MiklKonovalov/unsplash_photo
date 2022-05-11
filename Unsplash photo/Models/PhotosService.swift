//
//  PhotosService.swift
//  Unsplash photo
//
//  Created by Misha on 06.05.2022.
//

import Foundation
import UIKit

class PhotosSevice {
    
    var results: [Results] = []
    
    func getPhotos(query: String) {
        let urlString = "https://api.unsplash.com/search/photos?page=1&per_page=50&query=\(query)&client_id=CW7VbRFxrEOMsJCTQKQqucPEL9EvYqNDNMfi7p2WZ6A"
        
        guard let url = URL(string: urlString) else { return }
    
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            guard let data = data, error == nil else { return }
        
            do {
                let jsonResult = try JSONDecoder().decode(APIResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.results = jsonResult.results
                    self?.serviceDidChange?()
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    var serviceDidChange: (() -> Void)?
}