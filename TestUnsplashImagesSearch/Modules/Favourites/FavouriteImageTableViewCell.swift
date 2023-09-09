//
//  FavouriteImageTableViewCell.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import UIKit

class FavouriteImageTableViewCell: UITableViewCell {

    @IBOutlet weak var previewImageView: UIImageView! {
        didSet {
            previewImageView.contentMode = .scaleAspectFill
            previewImageView.alpha = 1
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 1
            titleLabel.textColor = .label
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.numberOfLines = 1
            subtitleLabel.textColor = .label
        }
    }
    @IBOutlet weak var bottomLabel: UILabel! {
        didSet {
            bottomLabel.numberOfLines = 1
            bottomLabel.textColor = .tertiaryLabel
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .secondarySystemGroupedBackground
    }
}
