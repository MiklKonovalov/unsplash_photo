//
//  FavouritesPresenter.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import RealmSwift
import UIKit

protocol FavouritesPresenterProtocol {
    func viewWillAppear()
    func results() -> [String]?
    func resultCount() -> Int
}

class FavouritesPresenter {
    
    let realm = try! Realm()

    var favouritesService = FavouritesService()
    weak var favouritesPhotosViewController: FavouritesPhotosViewControllerProtocol?
    weak var detailsViewController: DetailsScreenViewController?
}

extension FavouritesPresenter: FavouritesPresenterProtocol {
    
    func viewWillAppear() {
        
        favouritesService.results.removeAll()
        
        favouritesService.serviceDidChange = {
            self.favouritesPhotosViewController?.reload()
        }
        
        let stored = self.realm.objects(IdList.self)
        for index in stored.enumerated() {
            self.favouritesService.getFavouritePhotos(query: index.element.id)
        }
    }
    
    func resultCount() -> Int {
        return favouritesService.results.count
    }
    
    func results() -> [String]? {
        let result = favouritesService.results
        return result
    }
    
}
