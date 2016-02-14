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


class PropertySpec: QuickSpec {
    override func spec() {
        describe("Property") {
            describe("map") {
                it("transforms value", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let foo = Variable("foo")
                    let length = Variable(0)
                    foo.map { $0.characters.count }.bindTo(length).addTo(bag)
                    expect(length.value).to(equal(3))
                    foo.value = "hogehoge"
                    expect(length.value).to(equal(8))
                }
            }
            describe("distinct") {
                it("returns property which changed signal doesn't emit same values successively") {
                    let bag = SubscriptionBag()
                    let foo = Variable("foo")
                    let distincted = foo.distinct
                    var sent = [String]()
                    distincted.changed.subscribe { sent.append($0) }.addTo(bag)
                    foo.value = "bar"
                    foo.value = "bar"
                    foo.value = "baz"
                    foo.value = "baz"
                    expect(distincted.value).to(equal("baz"))
                    expect(sent).to(equal(["bar", "baz"]))
                }
            }
            describe("combine") {
                it("combines 2 values", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let firstName = Variable("Foo")
                    let lastName = Variable("Bar")
                    let fullName = combine(firstName, lastName) { "\($0) \($1)" }
                    let fullNameStore = Variable("")
                    fullName.bindTo(fullNameStore).addTo(bag)
                    expect(fullNameStore.value).to(equal("Foo Bar"))
                    firstName.value = "Piyo"
                    expect(fullNameStore.value).to(equal("Piyo Bar"))
                    lastName.value = "Nyan"
                    expect(fullNameStore.value).to(equal("Piyo Nyan"))
                }
                it("combines 3 values", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let firstName = Variable("Foo")
                    let middleName = Variable("aaa")
                    let lastName = Variable("Bar")
                    let fullName = combine(firstName, middleName, lastName) { "\($0) \($1) \($2)" }
                    let fullNameStore = Variable("")
                    fullName.bindTo(fullNameStore).addTo(bag)
                    expect(fullNameStore.value).to(equal("Foo aaa Bar"))
                    firstName.value = "Piyo"
                    expect(fullNameStore.value).to(equal("Piyo aaa Bar"))
                    lastName.value = "Nyan"
                    expect(fullNameStore.value).to(equal("Piyo aaa Nyan"))
                    middleName.value = "bbb"
                    expect(fullNameStore.value).to(equal("Piyo bbb Nyan"))
                }
            }
            it("unsubscribes upstream on destruction", andCleansUpResources: true) {
                let foo = Variable("Hoge")
                ({
                    let bag = SubscriptionBag()
                    let upper = Variable("")
                    let lower = Variable("")
                    foo.map { $0.uppercaseString }.bindTo(upper).addTo(bag)
                    foo.map { $0.lowercaseString }.bindTo(lower).addTo(bag)
                    foo.value = "FooBar"
                    expect(foo.changed.subscribersCount).to(equal(2))
                    expect(upper.value).to(equal("FOOBAR"))
                    expect(lower.value).to(equal("foobar"))
                })()
                expect(foo.changed.subscribersCount).to(equal(0))
            }
        }
    }
}