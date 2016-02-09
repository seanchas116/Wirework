import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIViewSpec: QuickSpec {
    override func spec() {
        describe("UIViewSpec") {
            describe("wwAlpha") {
                it("reflects alpha", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(CGFloat(0.2))
                    
                    variable.bindTo(view.wwAlpha).storeIn(bag)
                    expect(view.alpha).to(beCloseTo(0.2))
                    
                    variable.value = 0.8
                    expect(view.alpha).to(beCloseTo(0.8))
                }
            }
            describe("wwHidden") {
                it("reflects hidden", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(true)
                    
                    view.hidden = false
                    
                    variable.bindTo(view.wwHidden).storeIn(bag)
                    expect(view.hidden).to(beTrue())
                    
                    variable.value = false
                    expect(view.hidden).to(beFalse())
                }
            }
            describe("wwUserInteractionEnabled") {
                it("reflects userInteractionEnabled", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(true)
                    
                    view.userInteractionEnabled = false
                    
                    variable.bindTo(view.wwUserInteractionEnabled).storeIn(bag)
                    expect(view.userInteractionEnabled).to(beTrue())
                    
                    variable.value = false
                    expect(view.userInteractionEnabled).to(beFalse())
                }
            }
            describe("wwTintColor") {
                it("reflects tintColor", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(UIColor.whiteColor())
                    
                    variable.bindTo(view.wwTintColor).storeIn(bag)
                    expect(view.tintColor).to(equal(UIColor.whiteColor()))
                    
                    variable.value = UIColor.blueColor()
                    expect(view.tintColor).to(equal(UIColor.blueColor()))
                }
            }
            describe("wwBackgroundColor") {
                it("reflects backgroundColor", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(UIColor.whiteColor())
                    
                    variable.bindTo(view.wwBackgroundColor).storeIn(bag)
                    expect(view.backgroundColor).to(equal(UIColor.whiteColor()))
                    
                    variable.value = UIColor.blueColor()
                    expect(view.backgroundColor).to(equal(UIColor.blueColor()))
                }
            }
        }
    }
}
