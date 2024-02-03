//
//  RecentlyGeneratedViewController.swift
//  RandomAppGenerator
//
//  Created by Sudhanshu Kadari on 1/27/24.
//

import Foundation
import UIKit

class RecentlyGeneratedViewController: UIViewController {

    var imageArr: [UIImage]?
    
    var collectionView: UICollectionView = {
        let lay = UICollectionViewFlowLayout()
        lay.scrollDirection = .horizontal
        lay.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: lay)
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = true
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.contentMode = .scaleAspectFill
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy var clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Clear Dogs!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 66 / 255, green: 134/255, blue: 244/255, alpha: 1)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "My Recently Generated Dogs!"
        
        self.setupViews()
        
        self.setupCollectionView()
    }

    private func setupViews() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.clearButton)
        
        self.collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.clearButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -60).isActive = true
        self.clearButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.clearButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.clearButton.layoutIfNeeded()
        self.clearButton.layer.cornerRadius = self.clearButton.bounds.size.height/2
        self.clearButton.layer.masksToBounds = true
    }
    
    private func setupCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ImageCollectionCell.self, forCellWithReuseIdentifier: "ImageCollectionCell.class")
        self.collectionView.reloadData()
    }
}

extension RecentlyGeneratedViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArr?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionCell.class", for: indexPath) as? ImageCollectionCell {
            cell.imageView.image = imageArr![indexPath.item]
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 150)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: self.view.bounds.width, height: 150)
//    }
}

extension RecentlyGeneratedViewController {
    
    @objc func clearButtonTapped() {
        self.imageArr = nil
        self.collectionView.reloadData()
        nodesDict = [:]
        list = DoublyLinkedList<CachePayload>()
    }
}
