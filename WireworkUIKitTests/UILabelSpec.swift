import Foundation
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UILabelSpec: QuickSpec {
    override func spec() {
        describe("UILabel") {
            describe("wwText") {
                it("reflect UILabel text", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let label = UILabel()
                    let variable = Variable("foo")
                    
                    variable.bindTo(label.wwText).addTo(bag)
                    expect(label.text).to(equal("foo"))
                    
                    variable.value = "bar"
                    expect(label.text).to(equal("bar"))
                }
            }
            
            describe("wwAttributedText") {
                it("reflects UILabel attributedText", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let text1 = NSAttributedString(string: "foo")
                    let text2 = NSAttributedString(string: "bar")
                    
                    let label = UILabel()
                    let variable = Variable(text1)
                    
                    variable.bindTo(label.wwAttributedText).addTo(bag)
                    expect(label.attributedText).to(equal(text1))
                    
                    variable.value = text2
                    expect(label.attributedText).to(equal(text2))
                }
            }
            
            describe("wwTextColor") {
                it("reflects UILabel textColor", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let label = UILabel()
                    let variable = Variable(UIColor.redColor())
                    
                    variable.bindTo(label.wwTextColor).addTo(bag)
                    expect(label.textColor).to(equal(UIColor.redColor()))
                    
                    variable.value = UIColor.blueColor()
                    expect(label.textColor).to(equal(UIColor.blueColor()))
                }
            }
            
            describe("wwEnabled") {
                it("reflects UILabel enabled", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let label = UILabel()
                    let variable = Variable(false)
                    
                    variable.bindTo(label.wwEnabled).addTo(bag)
                    expect(label.enabled).to(beFalse())
                    
                    variable.value = true
                    expect(label.enabled).to(beTrue())
                }
            }
        }
    }
}
