import UIKit
import Wirework

class WWTableViewDelegate: WWScrollViewDelegate, UITableViewDelegate {
    private let _itemSelected = Event<NSIndexPath>()
    
    var itemSelected: Signal<NSIndexPath> { return _itemSelected }
    
    override init() {
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        _itemSelected.emit(indexPath)
    }
}

public class WWTableViewDataSource<Element>: NSObject, UITableViewDataSource {
    public let elements: Variable<[Element]>
    public let cellIdentifier: String
    private let _bind: (Int, Element, UITableViewCell) -> Void
    
    public init(elements: Variable<[Element]>, cellIdentifier: String, bind: (Int, Element, UITableViewCell) -> Void) {
        self.elements = elements
        self.cellIdentifier = cellIdentifier
        _bind = bind
    }
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier)!
        _bind(indexPath.row, elements.value[indexPath.row], cell)
        return cell
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.value.count
    }
}

private var dataSourceKey = 0

extension UITableView {
    public func wwSetAndRetainDataSource(dataSource: UITableViewDataSource) {
        self.dataSource = dataSource
        objc_setAssociatedObject(self, &dataSourceKey, dataSource, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
