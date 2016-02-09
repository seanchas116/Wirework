import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UITextViewSpec: QuickSpec {
    override func spec() {
        describe("UITextViewSpec") {
            describe("wwText") {
                it("reflects text", andCleansUpResources: true) {
                    let textView = UITextView()
                    
                    let bag = SubscriptionBag()
                    let variable = Variable("foobar")
                    
                    variable.bindTo(textView.wwText).storeIn(bag)
                    expect(textView.text).to(equal("foobar"))
                    
                    variable.value = "poepoe"
                    expect(textView.text).to(equal("poepoe"))
                }
            }
        }
    }
}
