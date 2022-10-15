//
//  DetailsScreenViewController.swift
//  Unsplash photo
//
//  Created by Misha on 08.05.2022.
//

import Foundation
import UIKit
import Kingfisher
import RealmSwift

class IdList: Object {
    @objc dynamic var id = ""
    @objc dynamic var isLike = false
}

protocol DetailsScreenViewControllerProtocol {
    
}

class DetailsScreenViewController: UIViewController {
    
    let realm = try! Realm()
    let photoId = IdList()
    
    var photosService: PhotoServiceProviding
    
    var favouritesPresenter: FavouritesPresenterProtocol
    
    var index: Int
    
    var count = 0
    
    var id: String?
    
    let photoImageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        }()
    
    var likeButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.layer.backgroundColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("В избранное", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(photosService: PhotoServiceProviding, index: Int, favouritesPresenter: FavouritesPresenterProtocol) {
        self.photosService = photosService
        self.index = index
        self.favouritesPresenter = favouritesPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if photoId.isLike == true {
            likeButton.setTitle("В избранном", for: .normal)
        } else if photoId.isLike == false {
            likeButton.setTitle("В избранное", for: .normal)
        }
        
        view.backgroundColor = .white
        
        view.addSubview(photoImageView)
        view.addSubview(authorLabel)
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(likesLabel)
        view.addSubview(likeButton)
        
        setupConstraints()
        
        let urlString = photosService.results[index].urls.small
        let url = URL(string: urlString)
        photoImageView.kf.setImage(with: url) { result in
            self.view.setNeedsLayout()
        }
        
        authorLabel.text = "Author: \(photosService.results[index].user.username)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = photosService.results[index].created_at
        guard let dateDate = dateFormatter.date(from: date) else { return }
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let dateString = dateFormatter.string(from: dateDate)
        dateLabel.text = "Date: \(dateString)"
        
        locationLabel.text = "Location: \(photosService.results[index].user.location ?? "Unknown location")"
        
        likesLabel.text = String("Likes: \(photosService.results[index].likes)")
        
        id = photosService.results[index].id
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.favouritesPresenter.viewDidLoad()
    
    }
    
    func setupConstraints() {
        
        photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        photoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        authorLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 40).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: photoImageView.leadingAnchor).isActive = true
        authorLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: authorLabel.leadingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        likesLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor).isActive = true
        likesLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: likesLabel.bottomAnchor, constant: 10).isActive = true
        likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func likeButtonPressed() {
        if count == 0 {
            count += 1
            likeButton.setTitle("В избранном", for: .normal)
            guard let id = id else { return }
            
            photoId.id = id
            photoId.isLike = true
            
            try! realm.write {
                realm.add(photoId)
            }
            
            favouritesPresenter.viewDidLoad()
        } else if count == 1 {
            count -= 1
            likeButton.setTitle("В избранное", for: .normal)
            photoId.isLike = false
        }
    }
}

extension DetailsScreenViewController: DetailsScreenViewControllerProtocol {
    
}

