import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UITextFieldSpec: QuickSpec {
    override func spec() {
        describe("UITextFieldSpec") {
            describe("wwText") {
                it("reflects text", andCleansUpResources: true) {
                    let textField = UITextField()
                    
                    let bag = SubscriptionBag()
                    let variable = Variable("foobar")
                    
                    variable.bindTo(textField.wwText).addTo(bag)
                    expect(textField.text).to(equal("foobar"))
                    
                    variable.value = "poepoe"
                    expect(textField.text).to(equal("poepoe"))
                }
            }
            
            describe("wwTextChanged") {
                it("emits text changes", andCleansUpResources: true) {
                    let textField = UITextField()
                    
                    let bag = SubscriptionBag()
                    var value = "foobar"
                    textField.wwTextChanged.subscribe { value = $0! }.addTo(bag)
                    
                    textField.text = "foobar"
                    textField.sendActionsForControlEvents(.ValueChanged)
                    
                    expect(value).to(equal("foobar"))
                }
            }
        }
    }
}
