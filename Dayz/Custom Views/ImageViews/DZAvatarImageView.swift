//
//  DZAvatarImageView.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 3.12.2025.
//

import UIKit

class DZAvatarImageView: UIImageView {
    
    let placeHolderImage = UIImage(systemName: SFSymbols.emptyProfile)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds      = true // image would still look like a sharp square unless we did the clipsToBounds true
        image              = placeHolderImage
        tintColor          = .secondaryLabel
    }
    
    // MARK: - Load Image from URL
    func setImage(from urlString: String?) {
        // 0. Nil or empty check
        guard let urlString = urlString, !urlString.isEmpty else {
            self.image = placeHolderImage
            return
        }
        
        let cacheKey = NSString(string: urlString)
        
        // 1. Check if it exists in cache
        if let cachedImage = NetworkManager.shared.imageCache.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        // 2. String → URL
        guard let url = URL(string: urlString) else {
            self.image = placeHolderImage
            return
        }
        
        // 3. download image async from URL
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let self = self else { return }
            guard let data = data, error == nil else { return }
            
            if let downloadedImage = UIImage(data: data) {
                NetworkManager.shared.imageCache.setObject(downloadedImage, forKey: cacheKey)
                
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}
