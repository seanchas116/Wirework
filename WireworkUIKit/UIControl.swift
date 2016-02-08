import Foundation
import UIKit
import Wirework

class WWControlTarget: NSObject {
    weak var _control: UIControl?
    private let _callback: () -> Void
    
    init(control: UIControl, events: UIControlEvents, callback: () -> Void) {
        _control = control
        _callback = callback
        super.init()
        control.addTarget(self, action: Selector("action"), forControlEvents: events)
    }
    
    func action() {
        _callback()
    }
    
    deinit {
        _control?.removeTarget(self, action: nil, forControlEvents: UIControlEvents.AllEvents)
    }
}

extension UIControl {
    public func wwControlEvent(events: UIControlEvents) -> Signal<UIControlEvents> {
        return createSignal { emit in
            return WWControlTarget(control: self, events: events) {
                emit(events)
            }
        }
    }
    
    public var wwEnabled: (Bool) -> Void {
        return { [weak self] in
            self?.enabled = $0
        }
    }
    
    public var wwSelected: (Bool) -> Void {
        return { [weak self] in
            self?.selected = $0
        }
    }
    
    public var wwHighlighted: (Bool) -> Void {
        return { [weak self] in
            self?.highlighted = $0
        }
    }
}