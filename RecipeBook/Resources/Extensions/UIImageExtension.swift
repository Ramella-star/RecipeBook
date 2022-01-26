//
//  UIImageExtension.swift
//  RecipeBook
//
//  Created by Admin on 14.01.2022.
//

import UIKit

extension UIImage {
    
    static var arrow = getImageByName("launcherImage")
    
    static func getImageByName(_ name: String) -> UIImage {
        #if TARGET_INTERFACE_BUILDER
            return UIImage()
        #else
            guard let image = UIImage(named: name)
                else { fatalError("Image with name \(name) not found.") }
            
            return image
        #endif
    }

}
