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
            it("binds value") {
                let foo = Variable("foo")
                let length = foo.map { $0.characters.count }
                expect(length.value).to(equal(3))
                foo.value = "hogehoge"
                expect(length.value).to(equal(8))
            }
        }
    }
}