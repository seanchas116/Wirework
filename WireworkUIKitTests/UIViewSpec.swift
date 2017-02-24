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
                    
                    variable.bindTo(view.wwAlpha).addTo(bag)
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
                    
                    view.isHidden = false
                    
                    variable.bindTo(view.wwHidden).addTo(bag)
                    expect(view.isHidden).to(beTrue())
                    
                    variable.value = false
                    expect(view.isHidden).to(beFalse())
                }
            }
            describe("wwUserInteractionEnabled") {
                it("reflects userInteractionEnabled", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(true)
                    
                    view.isUserInteractionEnabled = false
                    
                    variable.bindTo(view.wwUserInteractionEnabled).addTo(bag)
                    expect(view.isUserInteractionEnabled).to(beTrue())
                    
                    variable.value = false
                    expect(view.isUserInteractionEnabled).to(beFalse())
                }
            }
            describe("wwTintColor") {
                it("reflects tintColor", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(UIColor.white)
                    
                    variable.bindTo(view.wwTintColor).addTo(bag)
                    expect(view.tintColor).to(equal(UIColor.white))
                    
                    variable.value = UIColor.blue
                    expect(view.tintColor).to(equal(UIColor.blue))
                }
            }
            describe("wwBackgroundColor") {
                it("reflects backgroundColor", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let view = UIView()
                    let variable = Variable(UIColor.white)
                    
                    variable.bindTo(view.wwBackgroundColor).addTo(bag)
                    expect(view.backgroundColor).to(equal(UIColor.white))
                    
                    variable.value = UIColor.blue
                    expect(view.backgroundColor).to(equal(UIColor.blue))
                }
            }
        }
    }
}
