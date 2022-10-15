//
//  TabBarController.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import UIKit

class TabBarController: UITabBarController {
    
    let mainPresenter = MainPresenter()
    let favouritesPresenter = FavouritesPresenter()
    
    fileprivate func createNavController(for rootViewController: UIViewController,
                                        title: String,
                                        image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        
        let photoScreenViewController = PhotosScreenViewController(presenter: mainPresenter)
        mainPresenter.photosScreenViewController = photoScreenViewController
        
        let favouritesPhotoViewController = FavouritesPhotosViewController(favouritesPresenter: favouritesPresenter)
        favouritesPresenter.favouritesPhotosViewController = favouritesPhotoViewController
        
        viewControllers = [
            createNavController(for: photoScreenViewController, title: NSLocalizedString("Лента", comment: ""), image: UIImage(systemName: "magnifyingglass")!),
            createNavController(for: favouritesPhotoViewController, title: NSLocalizedString("Избранное", comment: ""), image: UIImage(systemName: "house")!),
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().barTintColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
    }

}
