//
//  Assembly.swift
//  Unsplash photo
//
//  Created by Misha on 11.05.2022.
//

import UIKit

class Assembly {
    func assemble() -> UIViewController {
        let photosService = PhotosSevice()
        let presenter = MainPresenter()
        let photosScreenViewController = PhotosScreenViewController(photosService: photosService, presenter: presenter)
        return photosScreenViewController
    }
}
