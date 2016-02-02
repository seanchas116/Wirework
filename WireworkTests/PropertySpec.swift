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
                it("transforms value") {
                    let foo = Variable("foo")
                    let length = foo.map { $0.characters.count }
                    let lengthStore = Variable(0)
                    length.bindTo(lengthStore)
                    expect(lengthStore.value).to(equal(3))
                    foo.value = "hogehoge"
                    expect(lengthStore.value).to(equal(8))
                }
            }
            describe("combine") {
                it("combines values") {
                    let firstName = Variable("Foo")
                    let lastName = Variable("Bar")
                    let fullName = combine(firstName, lastName) { "\($0) \($1)" }
                    let fullNameStore = Variable("")
                    fullName.bindTo(fullNameStore)
                    expect(fullNameStore.value).to(equal("Foo Bar"))
                    firstName.value = "Piyo"
                    expect(fullNameStore.value).to(equal("Piyo Bar"))
                }
            }
            it("unsubscribes upstream on destruction") {
                let foo = Variable("Hoge")
                ({
                    let upper = Variable("")
                    let lower = Variable("")
                    foo.map { $0.uppercaseString }.bindTo(upper)
                    foo.map { $0.lowercaseString }.bindTo(lower)
                    foo.value = "FooBar"
                    expect(foo.changed.subscriptionCount).to(equal(2))
                    expect(upper.value).to(equal("FOOBAR"))
                    expect(lower.value).to(equal("foobar"))
                })()
                expect(foo.changed.subscriptionCount).to(equal(0))
            }
        }
    }
}