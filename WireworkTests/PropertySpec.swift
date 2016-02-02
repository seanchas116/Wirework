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
                    expect(length.value).to(equal(3))
                    foo.value = "hogehoge"
                    expect(length.value).to(equal(8))
                }
            }
            describe("combine") {
                it("combines values") {
                    let firstName = Variable("Foo")
                    let lastName = Variable("Bar")
                    let fullName = combine(firstName, lastName) { "\($0) \($1)" }
                    expect(fullName.value).to(equal("Foo Bar"))
                    firstName.value = "Piyo"
                    expect(fullName.value).to(equal("Piyo Bar"))
                }
            }
        }
    }
}