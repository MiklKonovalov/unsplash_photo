//
//  Assembly.swift
//  Unsplash photo
//
//  Created by Misha on 11.05.2022.
//

import UIKit

class Assembly {
    func assemble() -> UIViewController {
        let presenter = MainPresenter()
        let photosScreenViewController = PhotosScreenViewController(presenter: presenter)
        presenter.photosScreenViewController = photosScreenViewController
        return photosScreenViewController
    }
}
