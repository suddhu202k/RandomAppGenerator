//
//  ImageCollectionCell.swift
//  RandomAppGenerator
//
//  Created by Sudhanshu Kadari on 1/27/24.
//

import Foundation
import UIKit


class ImageCollectionCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createViews() {
        self.contentView.addSubview(self.imageView)
        self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
    }
}
