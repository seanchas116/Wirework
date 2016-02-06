//
//  UILabel.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/06.
//
//

import Foundation
import WireworkFoundation

extension UILabel {
    
    public var wwText: KeyValueProperty<String> {
        return wwKeyValue("text")
    }
    
}