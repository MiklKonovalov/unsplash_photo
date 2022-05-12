//
//  PhotoServiceMock.swift
//  Unsplash photoTests
//
//  Created by Misha on 11.05.2022.
//

import Foundation
@testable import Unsplash_photo

final class PhotoServiceMock: PhotoServiceProviding {
    
    var getPhotosCallCount = 0
    
    func getPhotos(query: String) {
        getPhotosCallCount += 1
    }
    
    var serviceDidChange: (() -> Void)?
    
    var results: [Results] = []
    
}
