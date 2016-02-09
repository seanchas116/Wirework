import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UIImageViewSpec: QuickSpec {
    override func spec() {
        describe("UIImageView") {
            describe("wwImage") {
                it("reflects image", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let image = UIImage()
                    
                    let view = UIImageView()
                    let variable = Variable<UIImage?>(nil)
                    
                    variable.bindTo(view.wwImage).storeIn(bag)
                    variable.value = image
                    
                    expect(view.image).to(equal(image))
                }
            }
            
            describe("wwHighlightedImage") {
                it("reflects highlightedImage", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    let image = UIImage()
                    
                    let view = UIImageView()
                    let variable = Variable<UIImage?>(nil)
                    
                    variable.bindTo(view.wwHighlightedImage).storeIn(bag)
                    variable.value = image
                    
                    expect(view.highlightedImage).to(equal(image))
                }
            }
        }
    }
}
