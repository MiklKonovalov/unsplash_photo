//
//  DetailsPresenter.swift
//  Unsplash photo
//
//  Created by Misha on 16.10.2022.
//

import Foundation
import RealmSwift
import UIKit

class IdList: Object {
    @objc dynamic var id = ""
}

protocol DetailsPresenterProtocol {
    func viewDidLoad(with index: Int)
    func photoDidLoad(with index: Int) -> String
    func authorDidLoad(with index: Int) -> String
    func dateDidLoad(with index: Int) -> String
    func locationDidLoad(with index: Int) -> String
    func downloadsDidLoad(with index: Int) -> Int
    func makeFavourites()
}

class DetailsPresenter {
    
    let realm = try! Realm()
    var id: String?
    
    var photosService: PhotoServiceProviding
    weak var detailsScreenViewController: DetailsScreenViewControllerProtocol?
    
    init(photosService: PhotoServiceProviding) {
        self.photosService = photosService
    }
}

extension DetailsPresenter: DetailsPresenterProtocol {
    
    func viewDidLoad(with index: Int) {
        
        let id = photosService.results[index].id
        self.id = id
        
        if realm.objects(IdList.self).filter("id == %@", id).isEmpty {
            detailsScreenViewController?.unfavourite()
        } else {
            detailsScreenViewController?.favourite()
        }
    }
    
    func photoDidLoad(with index: Int) -> String {
        let urlPhoto = photosService.results[index].urls.small
        return urlPhoto
    }
    
    func authorDidLoad(with index: Int) -> String {
        let author = photosService.results[index].user.username
        return author
    }
    
    func dateDidLoad(with index: Int) -> String {
        let date = photosService.results[index].created_at
        return date
    }
    
    func locationDidLoad(with index: Int) -> String {
        let location = photosService.results[index].user.location ?? "Unknowed"
        return location
    }
    
    func downloadsDidLoad(with index: Int) -> Int {
        let downloads = photosService.results[index].likes
        return downloads
    }
    
    func makeFavourites() {
        guard let id = id else { return }
        let isLiked = realm.objects(IdList.self).filter("id == %@", id)
        
        if isLiked.isEmpty {
            
            let idList = IdList()
            idList.id = id
            
            try! realm.write {
                realm.add(idList)
            }
            
            print(realm.objects(IdList.self))
            
            detailsScreenViewController?.favourite()
        } else {
            try! realm.write {
                realm.delete(isLiked)
                
                print(realm.objects(IdList.self))
            }
            detailsScreenViewController?.unfavourite()
        }
    }
    
}
