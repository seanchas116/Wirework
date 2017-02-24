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

func it(_ description: String, andCleansUpResources: Bool, closure: @escaping () -> Void) {
    if andCleansUpResources {
        it(description) {
            let origCount = ResourceMonitor.totalCount
            closure()
            expect(ResourceMonitor.totalCount).to(equal(origCount))
        }
    } else {
        it(description, closure: closure)
    }
}
