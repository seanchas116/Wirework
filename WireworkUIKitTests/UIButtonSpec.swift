import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIButtonSpec: QuickSpec {
    override func spec() {
        describe("UIButton") {
            describe("wwState") {
                describe("title") {
                    it("reflects title", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let button = UIButton()
                        let variable = Variable("foobar")
                        
                        variable.bindTo(button.wwState(.Selected).title).storeIn(bag)
                        expect(button.titleForState(.Selected)).to(equal("foobar"))
                        
                        variable.value = "poeee"
                        expect(button.titleForState(.Selected)).to(equal("poeee"))
                    }
                }
                
                describe("attributedTitle") {
                    it("reflects attributedTitle", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let title1 = NSAttributedString(string: "foo")
                        let title2 = NSAttributedString(string: "bar")
                        
                        let button = UIButton()
                        let variable = Variable(title1)
                        
                        variable.bindTo(button.wwState(.Selected).attributedTitle).storeIn(bag)
                        expect(button.attributedTitleForState(.Selected)).to(equal(title1))
                        
                        variable.value = title2
                        expect(button.attributedTitleForState(.Selected)).to(equal(title2))
                    }
                }
                
                describe("titleColor") {
                    it("reflects title color", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let button = UIButton()
                        let variable = Variable(UIColor.whiteColor())
                        
                        variable.bindTo(button.wwState(.Highlighted).titleColor).storeIn(bag)
                        expect(button.titleColorForState(.Highlighted)).to(equal(UIColor.whiteColor()))
                        
                        variable.value = UIColor.blueColor()
                        expect(button.titleColorForState(.Highlighted)).to(equal(UIColor.blueColor()))
                    }
                }
                
                describe("titleShadowColor") {
                    it("reflects titleShadowColor", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let button = UIButton()
                        let variable = Variable(UIColor.whiteColor())
                        
                        variable.bindTo(button.wwState(.Highlighted).titleShadowColor).storeIn(bag)
                        expect(button.titleShadowColorForState(.Highlighted)).to(equal(UIColor.whiteColor()))
                        
                        variable.value = UIColor.blueColor()
                        expect(button.titleShadowColorForState(.Highlighted)).to(equal(UIColor.blueColor()))
                    }
                }
                
                describe("image") {
                    it("reflects image", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let image1 = createImage(CGSizeMake(100, 100))
                        let image2 = createImage(CGSizeMake(200, 200))
                        
                        let button = UIButton()
                        let variable = Variable(image1)
                        
                        variable.bindTo(button.wwState(.Selected).image).storeIn(bag)
                        expect(button.imageForState(.Selected)).to(equal(image1))
                        
                        variable.value = image2
                        expect(button.imageForState(.Selected)).to(equal(image2))
                    }
                }
                
                describe("backgroundImage") {
                    it("reflects backgroundImage", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let image1 = createImage(CGSizeMake(100, 100))
                        let image2 = createImage(CGSizeMake(200, 200))
                        
                        let button = UIButton()
                        let variable = Variable(image1)
                        
                        variable.bindTo(button.wwState(.Selected).backgroundImage).storeIn(bag)
                        expect(button.backgroundImageForState(.Selected)).to(equal(image1))
                        
                        variable.value = image2
                        expect(button.backgroundImageForState(.Selected)).to(equal(image2))
                    }
                }
            }

            describe("wwTapped") {
                it("emits when tapped", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let button = UIButton()
                    var tapped = false
                    button.wwTapped.subscribe {
                        tapped = true
                    }.storeIn(bag)
                    button.sendActionsForControlEvents(.TouchUpInside)
                    expect(tapped).to(beTrue())
                }
            }
        }
    }
}
