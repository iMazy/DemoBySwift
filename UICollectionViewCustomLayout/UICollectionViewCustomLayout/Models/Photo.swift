//
//  Photo.swift
//  UICollectionViewCustomLayout
//
//  Created by Mazy on 2018/12/26.
//  Copyright © 2018 Mazy. All rights reserved.
//

import UIKit

struct Photo {
    
    var caption: String
    var comment: String
    var image: UIImage
    
    init(caption: String, comment: String, image: UIImage) {
        self.caption = caption
        self.comment = comment
        self.image = image
    }
    
    init?(dict: [String: String]) {
        guard let caption = dict["Caption"], let comment = dict["Comment"], let photo = dict["Photo"], let image = UIImage(named: photo) else {
            return nil
        }
        self.init(caption: caption, comment: comment, image: image)
    }
    
    static func allPhotos() -> [Photo] {
        var photos: [Photo] = []
        guard let url = Bundle.main.url(forResource: "Photos", withExtension: "plist"), let photosFromPlist = NSArray(contentsOf: url) as? [[String: String]] else {
            return photos
        }
        
        for dict in photosFromPlist {
            if let photo = Photo(dict: dict) {
                photos.append(photo)
            }
        }
        return photos
    }
}
