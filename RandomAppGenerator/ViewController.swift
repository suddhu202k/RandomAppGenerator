//
//  ViewController.swift
//  RandomAppGenerator
//
//  Created by Sudhanshu Kadari on 1/14/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Random Dog Generator!"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var generateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate Dogs!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 66 / 255, green: 134/255, blue: 244/255, alpha: 1)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var recentlyGeneratedButton: UIButton = {
        let button = UIButton()
        button.setTitle("My Recently Generated Dogs!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 66 / 255, green: 134/255, blue: 244/255, alpha: 1)
        button.addTarget(self, action: #selector(recentlyGeneratedTapped), for: .touchUpInside)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.generateButton)
        self.view.addSubview(self.recentlyGeneratedButton)
        self.titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0.3*UIScreen.main.bounds.height).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.generateButton.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 60).isActive = true
        self.generateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.generateButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        self.generateButton.layoutIfNeeded()
        self.generateButton.layer.cornerRadius = self.generateButton.bounds.size.height/2
        self.generateButton.layer.masksToBounds = true

        self.recentlyGeneratedButton.topAnchor.constraint(equalTo: self.generateButton.bottomAnchor, constant: 20).isActive = true
        self.recentlyGeneratedButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.recentlyGeneratedButton.widthAnchor.constraint(equalToConstant: 260).isActive = true
        
        self.recentlyGeneratedButton.layoutIfNeeded()
        self.recentlyGeneratedButton.layer.cornerRadius = self.recentlyGeneratedButton.bounds.size.height/2
        self.recentlyGeneratedButton.layer.masksToBounds = true
    }

}

@objc
extension ViewController {
    
    private func generateTapped() {
        let vc = GenerateViewController()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func recentlyGeneratedTapped() {
        let cache = CacheLRU()
        
        let vc = RecentlyGeneratedViewController()
        vc.imageArr = cache.getAllImages()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

