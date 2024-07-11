//
//  cell.swift
//  WallpaperApp
//
//  Created by spark-05 on 2024/07/10.
//

import Foundation
import UIKit

class Cell: UICollectionViewCell {
    
    var dataTask: URLSessionDataTask?
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    func setupViews() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    
    func configure(with photo: Result) {
        // 古いデータタスクをキャンセル
        dataTask?.cancel()
        
        guard let regularUrl = photo.urls.regular,
        let url = URL(string: regularUrl)
        else {
            return
        }
        
        dataTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard let data = data, let image = UIImage(data: data) else {
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
                self?.imageView.contentMode = .scaleAspectFill
            }
        }
        dataTask?.resume()
    }
}
