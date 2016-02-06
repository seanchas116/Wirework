//
//  Util.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/06.
//
//

import Foundation
import Quick
import Nimble
import Wirework

func expectCleanedUp(block: () -> Void) {
    let resCount = ResourceMonitor.totalCount
    block()
    expect(ResourceMonitor.hasUsed).to(beTrue())
    expect(ResourceMonitor.totalCount).to(equal(resCount))
}