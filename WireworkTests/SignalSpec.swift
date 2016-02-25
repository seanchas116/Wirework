//
//  PropertySpec.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/02.
//
//

import Foundation
import Quick
import Nimble
import Wirework

class SignalSpec: QuickSpec {
    override func spec() {
        describe("Signal") {
            describe("map") {
                it("maps value", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let ev = Event<String>()
                    var received = [Int]()
                    ev.map { $0.characters.count }.subscribe {
                        received.append($0)
                    }.addTo(bag)
                    ev.emit("foobar")
                    expect(received).to(equal([6]))
                }
            }
            describe("mapAsnyc") {
                it("maps value asynchronously", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let ev = Event<String>()
                    var received = [Int]()
                    ev.mapAsync { value, callback in callback(value.characters.count) }.subscribe {
                        received.append($0)
                    }.addTo(bag)
                    ev.emit("foobar")
                    expect(received).to(equal([6]))
                }
            }
            describe("filter") {
                it("filters value", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let ev = Event<String>()
                    var received = [String]()
                    ev.filter { $0.characters.count > 5 }.subscribe {
                        received.append($0)
                    }.addTo(bag)
                    ev.emit("piyo")
                    ev.emit("foobar")
                    ev.emit("hoge")
                    expect(received).to(equal(["foobar"]))
                }
            }
        }
    }
}
