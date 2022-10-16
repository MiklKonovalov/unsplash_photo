//
//  Photos.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import UIKit

struct APIResponse: Codable {
    let total: Int
    let total_pages: Int
    let results: [Results]
}

struct Results: Codable {
    let id: String
    let created_at: String
    let urls: URLS
    let user: User
    let likes: Int
}

struct URLS: Codable {
    let small: String
}

struct User: Codable {
    let username: String
    let location: String?
}



    
