//
//  Presentors.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import UIKit

protocol MainPresenterProtocol {
    func viewDidLoad()
    func viewDidSearch(text: String)
    func resultCount() -> Int
    func results() -> [Results]?
    func openNewScreen(row: Int)
    
}

class MainPresenter {
    var photosService = PhotosSevice()
    weak var photosScreenViewController: PhotosScreenViewControllerProtocol?
    let favouritesPresenter = FavouritesPresenter()
}

extension MainPresenter: MainPresenterProtocol {

    func viewDidLoad() {
        photosService.getPhotos(query: "Box")
        photosService.serviceDidChange = {
            self.photosScreenViewController?.reload()
        }
    }
    
    func viewDidSearch(text: String) {
        photosService.results = []
        photosScreenViewController?.reload()
        photosService.getPhotos(query: text)
    }
    
    func resultCount() -> Int {
        let resultCount = photosService.results.count
        return resultCount
    }
    
    func results() -> [Results]? {
        let result = photosService.results
        return result
    }
    
    func openNewScreen(row: Int) {
        let detailsPresenter = DetailsPresenter(photosService: photosService)
        
        let detailsScreenViewController = DetailsScreenViewController(
            index: row,
            detailsPresenter: detailsPresenter)
        
        detailsPresenter.detailsScreenViewController = detailsScreenViewController
        
        photosScreenViewController?.present(view: detailsScreenViewController)
    }
    
}
