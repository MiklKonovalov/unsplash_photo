//
//  FavouritesPresenter.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import RealmSwift

protocol FavouritesPresenterProtocol {
    func viewDidLoad()
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
    
    func viewDidLoad() {
        
        let stored = realm.objects(IdList.self)
        for index in stored.enumerated() {
            favouritesService.getFavouritePhotos(query: index.element.id)
            print(index)
        }
        
        favouritesService.serviceDidChange = {
            self.favouritesPhotosViewController?.reload()
        }
    }
    
    func resultCount() -> Int {
        let stored = realm.objects(IdList.self)
        return stored.count
    }
    
    func results() -> [String]? {
        let result = favouritesService.results
        return result
    }
    
}
