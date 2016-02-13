import UIKit
import Wirework

public class WWTableViewDelegate: WWScrollViewDelegate, UITableViewDelegate {
    public override init() {
        
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

extension UITableView {
}
