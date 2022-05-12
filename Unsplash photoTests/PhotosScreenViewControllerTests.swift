//
//  PhotosScreenViewControllerTests.swift
//  Unsplash photoTests
//
//  Created by Misha on 11.05.2022.
//

import XCTest
@testable import Unsplash_photo

class PhotosScreenViewControllerTests: XCTestCase {

    func testViewDidLoad() {
        let photoService = PhotoServiceMock()
        let photosScreenViewController = PhotosScreenViewController(photosService: photoService)
        let _ = photosScreenViewController.view
        
        XCTAssertEqual(photoService.getPhotosCallCount, 1)
    }

}
