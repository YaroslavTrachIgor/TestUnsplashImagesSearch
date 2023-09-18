//
//  ImageCollectionViewCell.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import Foundation
import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = String(describing: ImageCollectionViewCell.self)
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    func configure(with url: URL) {
        imageView.downloadImage(with: url)
    }
}
