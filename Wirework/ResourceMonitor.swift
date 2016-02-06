//
//  ResourceMonitor.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/06.
//
//

import Foundation

public class ResourceMonitor {
    public init() {
        ResourceMonitor._totalCount += 1
        ResourceMonitor._hasUsed = true
    }
    
    deinit {
        ResourceMonitor._totalCount -= 1
    }
    
    public static var totalCount: Int {
        return _totalCount
    }
    
    public static var hasUsed: Bool {
        return _hasUsed
    }
    
    private static var _totalCount = 0
    private static var _hasUsed = false
}