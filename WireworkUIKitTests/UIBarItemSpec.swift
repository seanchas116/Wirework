import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIBarItemSpec: QuickSpec {
    override func spec() {
        describe("UIBarItem") {
            describe("wwTitle") {
                it("reflects title", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let item = UIBarButtonItem()
                    let variable = Variable("foobar")
                    
                    variable.bindTo(item.wwTitle).addTo(bag)
                    expect(item.title).to(equal("foobar"))
                    
                    variable.value = "poeee"
                    expect(item.title).to(equal("poeee"))
                }
            }
            
            describe("wwImage") {
                it("reflects image", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let image1 = createImage(size: CGSize(width: 100, height: 100))
                    let image2 = createImage(size: CGSize(width: 200, height: 200))
                    
                    let item = UIBarButtonItem()
                    let variable = Variable(image1)
                    
                    variable.bindTo(item.wwImage).addTo(bag)
                    expect(item.image).to(equal(image1))
                    
                    variable.value = image2
                    expect(item.image).to(equal(image2))
                }
            }
            
            describe("wwEnabled") {
                it("reflects enabled", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let item = UIBarButtonItem()
                    let variable = Variable(true)
                    
                    item.isEnabled = false
                    
                    variable.bindTo(item.wwEnabled).addTo(bag)
                    expect(item.isEnabled).to(beTrue())
                    
                    variable.value = false
                    expect(item.isEnabled).to(beFalse())
                }
            }
        }
    }
}
