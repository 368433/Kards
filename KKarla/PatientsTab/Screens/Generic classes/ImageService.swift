//
//  ImageService.swift
//  Karla
//
//  Created by amir2 on 2018-04-10.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class ImageService{
    
    public func getImage(for name: String?) -> UIImage? {
        guard let name = name else {return nil}
        let imageURL = getDocumentsDirectory().appendingPathComponent(name)
        let imagePath = imageURL.path
        return UIImage(contentsOfFile: imagePath)
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
