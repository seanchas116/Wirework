//
//  UIScrollView.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/09.
//
//

import UIKit
import Wirework

private var delegateKey = 0

public class WWScrollViewDelegate: NSObject, UIScrollViewDelegate {
    public override init() {
    }
    
    let _didScroll = Event<CGPoint>()
    
    public var didScroll: Signal<CGPoint> {
        return _didScroll
    }
    
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        _didScroll.emit(scrollView.contentOffset)
    }
}

extension UIScrollView {
    public var wwScrollEnabled: (Bool) -> Void {
        return { [weak self] in
            self?.scrollEnabled = $0
        }
    }
    
    public func wwContentOffset(animated animated: Bool) -> (CGPoint) -> Void {
        return { [weak self] in
            self?.setContentOffset($0, animated: animated)
        }
    }
}
