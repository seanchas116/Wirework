import Foundation

public class Property<T>: PropertyType {
    public typealias Value = T
    
    public var changed: Signal<Value> {
        fatalError("not implemented")
    }
    public var value: Value {
        fatalError("not implemented")
    }
}

public class Variable<T>: Property<T> {
    
    private var _value: Value
    private let _changed = Event<Value>()
    private let _bag = SubscriptionBag()
    
    public override var changed: Signal<Value> {
        return _changed
    }
    
    public override var value: Value {
        get { return _value }
        set {
            _value = newValue
            _changed.emit(newValue)
        }
    }
    
    public init(_ value: Value) {
        _value = value
    }
}

class IntermediateProperty<T>: Property<T> {
    private let _getValue: () -> T
    private let _changed: Signal<T>
    
    init(_ changed: Signal<T>, _ getValue: () -> T) {
        _getValue = getValue
        _changed = changed
    }
    
    override var changed: Signal<T> {
        return _changed
    }
    
    override var value: T {
        return _getValue()
    }
}