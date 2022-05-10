//
//  PhotosScreenProtocol.swift
//  Unsplash photo
//
//  Created by Misha on 08.05.2022.
//

import Foundation

protocol PhotosScreenDelegate: AnyObject {
    func setup()
    func setupData(data: [Results])
    func displayData(i: Int)
}

protocol PhotosOutputScreenDelegate: AnyObject {
    func getData()
    func saveData() 
}
