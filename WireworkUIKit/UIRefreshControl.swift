//
//  UIRefreshControl.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import Foundation
import Wirework

extension UIRefreshControl {
    public var wwRefreshing: MutableProperty<Bool> {
        return createMutableProperty(wwControlEvent(.ValueChanged).map { _ in },
            getValue: { [weak self] in self?.refreshing ?? false },
            setValue: { [weak self] value in
                if value {
                    self?.beginRefreshing()
                } else {
                    self?.endRefreshing()
                }
                return
            }
        )
    }
}