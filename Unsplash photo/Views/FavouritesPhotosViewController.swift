//
//  FavouritesPhotosViewController.swift
//  Unsplash photo
//
//  Created by Misha on 13.10.2022.
//

import Foundation
import UIKit

protocol FavouritesPhotosViewControllerProtocol: AnyObject {
    func reload()
    func present(view: UIViewController)
}

class FavouritesPhotosViewController: UIViewController {
    
    let favouritesPresenter: FavouritesPresenterProtocol
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init(favouritesPresenter: FavouritesPresenterProtocol) {
        self.favouritesPresenter = favouritesPresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("viewDidLoad")
        
        view.backgroundColor = .white
        view.addSubview(tableView)
        setupTableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        self.favouritesPresenter.viewDidLoad()
    }
    
    func setupTableView() {
        tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
}

extension FavouritesPhotosViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favouritesPresenter.resultCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavoritesTableViewCell else { return UITableViewCell() }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let imageURLSring = self.favouritesPresenter.results()?[indexPath.row]
            cell.configure(with: imageURLSring ?? "")
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
}

extension FavouritesPhotosViewController: UITableViewDelegate {
    
}

extension FavouritesPhotosViewController: FavouritesPhotosViewControllerProtocol {
    
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func present(view: UIViewController) {
        
    }
    
    
}
