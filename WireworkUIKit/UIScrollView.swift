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

class WWScrollViewDelegate: NSObject, UIScrollViewDelegate {
    let didScroll = Event<CGPoint>()
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        didScroll.emit(scrollView.contentOffset)
    }
}

extension WWDelegateCascader: UIScrollViewDelegate {}

extension UIScrollView {
    var delegateCascader: WWDelegateCascader {
        if let delegate = self.delegate as? WWDelegateCascader {
            return delegate
        }
        if self.delegate != nil {
            fatalError("Exisitng delegate must be nil to install Wirework delegate")
        }
        let delegate = objc_getAssociatedObject(self, &delegateKey) as? WWDelegateCascader ?? WWDelegateCascader()
        objc_setAssociatedObject(self, &delegateKey, delegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.delegate = delegate
        return delegate
    }
    
    private var interceptDelegate: WWScrollViewDelegate {
        if let delegate = delegateCascader.delegate as? WWScrollViewDelegate {
            return delegate
        }
        let delegate = WWScrollViewDelegate()
        delegateCascader.delegate = delegate
        return delegate
    }
    
    public var wwDelegate: UIScrollViewDelegate? {
        get {
            return delegateCascader.proxy as? UIScrollViewDelegate
        }
        set {
            delegateCascader.proxy = newValue
        }
    }
    
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
    
    public var wwDidScroll: Signal<CGPoint> {
        return interceptDelegate.didScroll
    }
}
