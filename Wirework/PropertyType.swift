import Foundation

public protocol PropertyType: class {
    typealias Value
    var changed: Signal<Value> { get }
    var value: Value { get }
}

extension PropertyType {
    public func map<T>(transform: (Value) -> T) -> Property<T> {
        return AdapterProperty(changed.map(transform)) { transform(self.value) }
    }
    public func bindTo<T: InPropertyType where T.Value == Value>(dest: T) {
        dest.bind(self)
    }
}

public func combine<T1: PropertyType, T2: PropertyType>(p1: T1, _ p2: T2) -> Property<(T1.Value, T2.Value)> {
    let changed = merge(
        p1.changed.map { _ in (p1.value, p2.value) },
        p2.changed.map { _ in (p1.value, p2.value) }
    )
    return AdapterProperty(changed) { (p1.value, p2.value) }
}

public func combine<T1: PropertyType, T2: PropertyType, U>(p1: T1, _ p2: T2, transform: (T1.Value, T2.Value) -> U) -> Property<U> {
    return combine(p1, p2).map(transform)
}

public protocol InPropertyType: class {
    typealias Value
    func bind<T: PropertyType where T.Value == Value>(source: T)
}
