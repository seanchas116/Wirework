import Foundation

public class Property<T>: PropertyType {
    public typealias Value = T
    
    public var changed: Signal<Void> {
        fatalError("not implemented")
    }
    public var value: Value {
        fatalError("not implemented")
    }
}

public class Variable<T>: Property<T>, MutablePropertyType {
    private var _value: Value
    private let _changed = Event<Void>()
    
    public override var changed: Signal<Void> {
        return _changed
    }
    
    public override var value: Value {
        get { return _value }
        set {
            _value = newValue
            _changed.emit()
        }
    }

    public init(_ value: Value) {
        _value = value
    }
}

public class AdapterProperty<T>: Property<T> {
    private let _getValue: () -> T
    private let _changed: Signal<Void>
    
    public init(_ changed: Signal<Void>, _ getValue: () -> T) {
        _getValue = getValue
        _changed = changed
    }
    
    public override var changed: Signal<Void> {
        return _changed
    }
    
    public override var value: T {
        return _getValue()
    }
}
