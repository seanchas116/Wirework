//
//  CreateImage.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/09.
//
//

import UIKit

func createImage(size: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    
    context!.setFillColor(UIColor.red.cgColor)
    context!.fill(rect)
    
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return image!
}
