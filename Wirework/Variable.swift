import Foundation

class VariableData<T>: PropertyType {
    

    private var _value: T
    private let _bag = ConnectionBag()
    
    var value: T {
        get { return _value }
        set {
            let old = _value
            _value = newValue
            _notify(newValue, old)
        }
    }
    
    init(_ value: T) {
        _value = value
    }
    
    convenience init(_ other: VariableData<T>) {
        self.init(other.value)
    }
    
    private func _notify(new: Value, _ old: Value) {
        for observer in _observers.values {
            observer(new, old)
        }
    }
    
    typealias Value = T
    typealias Observer = (Value, Value) -> Void
    
    func storeConnection(connection: Connection) {
        _bag.storeConnection(connection)
    }
}

public struct Variable<T>: WireType, ConnectionBagType {
    public typealias Value = T
    private var _data: VariableData<Value>
    
    public var value: Value {
        get { return _data.value }
        set {
            if !isUniquelyReferencedNonObjC(&_data) {
                _data = VariableData(_data)
            }
            _data.value = newValue
        }
    }
    
    public func observe(observer: (Value, Value) -> Void) -> Connection {
        return _data.observe(observer)
    }
    
    public func storeConnection(connection: Connection) {
        _data.storeConnection(connection)
    }
    
    public init(_ value: Value) {
        _data = VariableData(value)
    }
}
