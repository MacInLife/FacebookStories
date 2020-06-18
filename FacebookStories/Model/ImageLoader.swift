//
//  ImageLoader.swift
//  FacebookStories
//
//  Created by Marie-Ange Coco on 18/06/2020.
//  Copyright © 2020 Marie-Ange Coco. All rights reserved.
//

import Foundation
import SDWebImage

class ImageLoader{
    func load(stringUrl: String?, imageView: UIImageView){
        guard let stringUrl = stringUrl, let url = URL(string: stringUrl) else {
            return
        }
        imageView.sd_setImage(with: url, completed: nil)
        
    }
}
