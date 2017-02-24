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
                        
                        variable.bindTo(button.wwState(.selected).title).addTo(bag)
                        expect(button.title(for: .selected)).to(equal("foobar"))
                        
                        variable.value = "poeee"
                        expect(button.title(for: .selected)).to(equal("poeee"))
                    }
                }
                
                describe("attributedTitle") {
                    it("reflects attributedTitle", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let title1 = NSAttributedString(string: "foo")
                        let title2 = NSAttributedString(string: "bar")
                        
                        let button = UIButton()
                        let variable = Variable(title1)
                        
                        variable.bindTo(button.wwState(.selected).attributedTitle).addTo(bag)
                        expect(button.attributedTitle(for: .selected)).to(equal(title1))
                        
                        variable.value = title2
                        expect(button.attributedTitle(for: .selected)).to(equal(title2))
                    }
                }
                
                describe("titleColor") {
                    it("reflects title color", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let button = UIButton()
                        let variable = Variable(UIColor.white)
                        
                        variable.bindTo(button.wwState(.highlighted).titleColor).addTo(bag)
                        expect(button.titleColor(for: .highlighted)).to(equal(UIColor.white))
                        
                        variable.value = UIColor.blue
                        expect(button.titleColor(for: .highlighted)).to(equal(UIColor.blue))
                    }
                }
                
                describe("titleShadowColor") {
                    it("reflects titleShadowColor", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let button = UIButton()
                        let variable = Variable(UIColor.white)
                        
                        variable.bindTo(button.wwState(.highlighted).titleShadowColor).addTo(bag)
                        expect(button.titleShadowColor(for: .highlighted)).to(equal(UIColor.white))
                        
                        variable.value = UIColor.blue
                        expect(button.titleShadowColor(for: .highlighted)).to(equal(UIColor.blue))
                    }
                }
                
                describe("image") {
                    it("reflects image", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let image1 = createImage(size: CGSize(width: 100, height: 100))
                        let image2 = createImage(size: CGSize(width: 200, height: 200))
                        
                        let button = UIButton()
                        let variable = Variable(image1)
                        
                        variable.bindTo(button.wwState(.selected).image).addTo(bag)
                        expect(button.image(for: .selected)).to(equal(image1))
                        
                        variable.value = image2
                        expect(button.image(for: .selected)).to(equal(image2))
                    }
                }
                
                describe("backgroundImage") {
                    it("reflects backgroundImage", andCleansUpResources: true) {
                        let bag = SubscriptionBag()
                        
                        let image1 = createImage(size: CGSize(width: 100, height: 100))
                        let image2 = createImage(size: CGSize(width: 200, height: 200))
                        
                        let button = UIButton()
                        let variable = Variable(image1)
                        
                        variable.bindTo(button.wwState(.selected).backgroundImage).addTo(bag)
                        expect(button.backgroundImage(for: .selected)).to(equal(image1))
                        
                        variable.value = image2
                        expect(button.backgroundImage(for: .selected)).to(equal(image2))
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
                    }.addTo(bag)
                    button.sendActions(for: .touchUpInside)
                    expect(tapped).to(beTrue())
                }
            }
        }
    }
}
