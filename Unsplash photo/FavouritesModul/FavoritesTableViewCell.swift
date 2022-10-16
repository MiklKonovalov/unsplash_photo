//
//  FavoritesTableViewCell.swift
//  Unsplash photo
//
//  Created by Misha on 14.10.2022.
//

import Foundation
import UIKit
import Kingfisher

class FavoritesTableViewCell: UITableViewCell {
    
    let favouriteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(favouriteImageView)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        favouriteImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        favouriteImageView.kf.cancelDownloadTask()
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        favouriteImageView.kf.setImage(with: url)
    }
    
}
