//
//  ViewController.swift
//  Unsplash photo
//
//  Created by Misha on 06.05.2022.
//

import UIKit

class PhotosScreenViewController: UIViewController, UISearchBarDelegate {
    
    let photosService: PhotosSevice
    //let mainPresenter = MainPresenter()
    let searchbar = UISearchBar()
    //var data = [Results]()
    //weak var photosOutputScreenDelegate: PhotosOutputScreenDelegate?
    
    var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    //var presenter: MainViewPresenterProtocol?
    
    init(photosService: PhotosSevice) {
        self.photosService = photosService
        //self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(mainCollectionView)
        view.addSubview(searchbar)
        searchbar.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
        
        //self.photosOutputScreenDelegate = mainPresenter
        //self.photosOutputScreenDelegate?.getData()
        
        self.searchbar.delegate = self
        
        self.mainCollectionView.delegate = self
        self.mainCollectionView.dataSource = self
        
        photosService.getPhotos(query: "Box")
        
        photosService.serviceDidChange = {
            DispatchQueue.main.async {
                self.mainCollectionView.reloadData()
            }
        }
        
        //presenter?.showPhotos()
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        mainCollectionView.frame = view.bounds
//    }
    
    func setupConstraints() {
        
        searchbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchbar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        searchbar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        searchbar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        mainCollectionView.topAnchor.constraint(equalTo: searchbar.bottomAnchor).isActive = true
        mainCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        mainCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        mainCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchbar.text {
            photosService.results = []
            mainCollectionView.reloadData()
            photosService.getPhotos(query: text)
        }
    }

}

extension PhotosScreenViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosService.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        let imageURLSring = photosService.results[indexPath.row].urls.small
        cell.configure(with: imageURLSring)
        cell.backgroundColor = .white
        return cell
    }
}

extension PhotosScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Переход к информации о фото", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default) { _ in
            let detailsScreenViewController = DetailsScreenViewController(photosService: self.photosService, index: indexPath.row)
            let navigationController = UINavigationController(rootViewController: detailsScreenViewController)
            self.present(navigationController, animated: true, completion: nil)
        })
        self.present(alert, animated: true, completion: nil)
    }
}

extension PhotosScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width / 2, height: view.frame.size.height / 4)
    }
}

//extension PhotosScreenViewController: PhotosScreenProtocol {
//    func setup() {
//        
//    }
//    
//    func setupData(data: [Results]) {
//        self.data = data
//    }
//    
//    func displayData(i: Int) {
//          
//    }
//    
//    
//}

