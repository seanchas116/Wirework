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

extension WWInterceptableDelegate: UIScrollViewDelegate {
}

extension UIScrollView {
    private func installDelegate() {
        if self.delegate is WWInterceptableDelegate {
            return
        }
        if self.delegate != nil {
            fatalError("Exisitng delegate must be nil to install Wirework delegate")
        }
        let delegate = objc_getAssociatedObject(self, &delegateKey) as? WWInterceptableDelegate ?? WWInterceptableDelegate()
        objc_setAssociatedObject(self, &delegateKey, delegate, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        self.delegate = delegate
    }
    
    private var interceptableDelegate: WWInterceptableDelegate {
        installDelegate()
        return self.delegate as! WWInterceptableDelegate
    }
    
    public func wwDelegate(selector: String) -> Signal<Void> {
        return interceptableDelegate.intercept(selector)
    }
    
    public var wwDelegate: UIScrollViewDelegate? {
        get {
            return interceptableDelegate.target as? UIScrollViewDelegate
        }
        set {
            interceptableDelegate.target = newValue
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
        return wwDelegate("scrollViewDidScroll:").map { [weak self] in
            self!.contentOffset
        }
    }
}
