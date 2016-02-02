import Foundation

public protocol PropertyType {
    typealias Value
    var changed: Signal<Value> { get }
    var value: Value { get }
}

extension PropertyType {
    public func map<T>(transform: (Value) -> T) -> Property<T> {
        return IntermediateProperty(changed.map(transform)) { transform(self.value) }
    }
}

public func combine<T1: PropertyType, T2: PropertyType>(p1: T1, p2: T2) -> Property<(T1.Value, T2.Value)> {
    let changed = merge(
        p1.changed.map { _ in (p1.value, p2.value) },
        p2.changed.map { _ in (p1.value, p2.value) }
    )
    return IntermediateProperty(changed) { (p1.value, p2.value) }
}