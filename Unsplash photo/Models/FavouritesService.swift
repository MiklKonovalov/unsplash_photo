//
//  FavouritesService.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import Foundation

class FavouritesService {
    
    var results: [String] = []
    
    func getFavouritePhotos(query: String) {
        let urlString = "https://api.unsplash.com/photos/\(query)?client_id=CW7VbRFxrEOMsJCTQKQqucPEL9EvYqNDNMfi7p2WZ6A"
        
        guard let url = URL(string: urlString) else { return }
    
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, responce, error in
            guard let data = data, error == nil else { return }
            print(error)
            
            guard let responce = responce as? HTTPURLResponse else { return }
            print("statusCode: \(responce.statusCode)")
        
            do {
                let jsonResult = try JSONDecoder().decode(PhotoResults.self, from: data)
                DispatchQueue.main.async {
                    self?.results.append(jsonResult.urls.small)
                    print("jsonResults: \(jsonResult.urls.small)")
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
