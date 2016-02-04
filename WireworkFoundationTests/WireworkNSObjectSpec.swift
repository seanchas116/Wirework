//
//  WireworkNSObjectSpec.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/04.
//
//


import Quick
import Nimble
import Wirework
import WireworkFoundation

class WWKVOObject: NSObject {
    dynamic var value = 1
}

class WireworkNSObjectSpec: QuickSpec {
    override func spec() {
        describe("NSObject") {
            describe("ww_propertyForKeyPath") {
                it("returns a mutable property that observes keypath") {
                    let bag = SubscriptionBag()
                    let obj = WWKVOObject()
                    let value = Variable(0)
                    obj.ww_propertyForKeyPath("value").bindTo(value).storeIn(bag)
                    expect(value.value).to(equal(1))
                    obj.value = 10
                    expect(value.value).to(equal(10))
                    obj.ww_propertyForKeyPath("value").value = 100
                    expect(obj.value).to(equal(100))
                }
            }
            describe("ww_bag") {
                it("holds subscriptions") {
                    var released = false
                    ({
                        let obj = NSObject()
                        Subscription { released = true }.storeIn(obj.ww_bag)
                        expect(released).to(equal(false))
                    })()
                    expect(released).to(equal(true))
                }
            }
        }
    }
}
