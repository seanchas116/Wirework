import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

private func createScrollView() -> UIScrollView {
    let scrollView = UIScrollView(frame: CGRectMake(0, 0, 100, 100))
    let view = UIView(frame: CGRectMake(0, 0, 200, 200))
    scrollView.addSubview(view)
    scrollView.contentSize = view.bounds.size
    return scrollView
}

class UIScrollViewSpec: QuickSpec {
    override func spec() {
        describe("UIScrollView") {
            describe("wwContentOffset") {
                it("reflects content offset", andCleansUpResources: true) {
                    let scroll = createScrollView()
                    
                    let bag = SubscriptionBag()
                    let variable = Variable(CGPointMake(20, 10))
                    
                    variable.bindTo(scroll.wwContentOffset(animated: false)).storeIn(bag)
                    expect(scroll.contentOffset).to(equal(CGPointMake(20, 10)))
                    
                    variable.value = CGPointMake(10, 20)
                    expect(scroll.contentOffset).to(equal(CGPointMake(10, 20)))
                }
            }
            describe("wwDidScroll") {
                it("emits on scrolViewDidScroll", andCleansUpResources: true) {
                    let scroll = createScrollView()
                    
                    let bag = SubscriptionBag()
                    
                    var offset = CGPointMake(0, 0)
                    scroll.wwDidScroll.subscribe { offset = $0 }.storeIn(bag)
                    scroll.contentOffset = CGPointMake(20, 10)
                    scroll.delegate?.scrollViewDidScroll?(scroll)
                    
                    expect(offset).to(equal(CGPointMake(20, 10)))
                }
            }
        }
    }
}
