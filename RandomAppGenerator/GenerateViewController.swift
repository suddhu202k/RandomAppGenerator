//
//  GenerateViewController.swift
//  RandomAppGenerator
//
//  Created by Sudhanshu Kadari on 1/15/24.
//

import UIKit

class GenerateViewController: UIViewController {
    
    lazy var imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = nil
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var generateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate!", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 66 / 255, green: 134/255, blue: 244/255, alpha: 1)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(generateTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Generate Dogs!"
        
        self.setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewWillDisappear(animated)
    }
    
    private func setupViews() {
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.generateButton)
        
        self.imageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        self.imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.imageView.trailingAnchor.constraint(lessThanOrEqualTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.imageView.bottomAnchor.constraint(lessThanOrEqualTo: self.generateButton.topAnchor, constant: -20).isActive = true
        
        self.generateButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        self.generateButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.generateButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.generateButton.layoutIfNeeded()
        self.generateButton.layer.cornerRadius = self.generateButton.bounds.size.height/2
        self.generateButton.layer.masksToBounds = true
    }
}

@objc
extension GenerateViewController {
    
    private func generateTapped() {
        if let url = URL(string: "https://dog.ceo/api/breeds/image/random") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    //
                } else if let data = data {
                    let decoder = JSONDecoder()
                    if let decodedData = try? decoder.decode(RandomImageModel.self, from: data), let imageURL = URL(string: decodedData.message) {
                        URLSession.shared.dataTask(with: imageURL) { imageData, response, error in
                            if let error = error {
                            } else if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                                if let imageData = imageData {
                                    // Dispatching UI update to the main queue
                                    DispatchQueue.main.async {
                                        let image: UIImage? = UIImage(data: imageData)
                                        self.imageView.image = image
                                        if let image = image {
                                            self.storeImage(image, decodedData.message)
                                        }
                                    }
                                } else {
                                   //
                                }
                            } else {
                                //
                            }
                        }.resume()
                    }
                } else if let response = response {
                    //
                }
            }.resume()
        }
    }
    
    private func storeImage(_ image: UIImage, _ imageURL: String) {
        
        let cache = CacheLRU()

        /// If present moving to head
        if let _ = cache.getValue(for: imageURL) {
            // Use the cached image
        } else {
            cache.setValue(image, for: imageURL)
        }

    }
}

