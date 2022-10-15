//
//  FavouritesData.swift
//  Unsplash photo
//
//  Created by Misha on 15.10.2022.
//

import UIKit

struct PhotoResults: Codable {
    let urls: PhotoURLS
}

struct PhotoURLS: Codable {
    let small: String
}

