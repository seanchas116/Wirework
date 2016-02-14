//
//  NSNotificationSpec.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/04.
//
//

import Foundation


import Quick
import Nimble
import Wirework
import WireworkFoundation

class NSNotificationSpeec: QuickSpec {
    override func spec() {
        describe("NSNotification") {
            describe("wwNotification") {
                it("returns a signal that emits notifications", andCleansUpResources: true) {
                    let obj = NSObject()
                    let signal = NSNotificationCenter.defaultCenter().wwNotification("test", object: obj)
                    var receivedValue: String?
                    ({
                        let bag = SubscriptionBag()
                        signal.subscribe {
                            receivedValue = $0.userInfo?["value"] as? String
                            }.addTo(bag)
                        NSNotificationCenter.defaultCenter().postNotificationName("test", object: obj, userInfo: ["value": "foobar"])
                        expect(receivedValue).to(equal("foobar"))
                    })()
                    receivedValue = nil
                    NSNotificationCenter.defaultCenter().postNotificationName("test", object: obj, userInfo: ["value": "hogehoge"])
                    expect(receivedValue).to(beNil())
                }
            }
        }
    }
}