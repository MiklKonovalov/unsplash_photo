//
//  Presentors.swift
//  Unsplash photo
//
//  Created by Misha on 06.05.2022.
//

import Foundation
import UIKit

protocol MainPresenterProtocol {
    func viewDidLoad()
    func reload()
}

class MainPresenter {
    var photosService: PhotosSevice?
    weak var photosScreenViewController: PhotosScreenViewControllerProtocol?

}

extension MainPresenter: MainPresenterProtocol {
    func viewDidLoad() {
        photosService?.getPhotos(query: "Box")
    }
    
    func reload() {
        photosService?.serviceDidChange = {
            self.photosScreenViewController?.reload()
        }
    }
    
}
