import UIKit
import Quick
import Nimble
import Wirework
import WireworkUIKit

class UITableViewSpec: QuickSpec {
    override func spec() {
        describe("UITableView") {
            describe("wwRows") {
                it("provides rows binding for UITableView", andCleansUpResources: true) {
                    let bag = SubscriptionBag()
                    
                    let tableView = UITableView(frame: CGRectMake(0, 0, 1000, 1000))
                    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
                    
                    let items = Variable(["foo", "bar", "baz"])
                    items.bindTo(tableView.wwRows("cell") { row, elem, cell in
                        cell.textLabel?.text = "\(row): \(elem)"
                    }).addTo(bag)
                    
                    let textAt: (Int) -> String? = {
                        let path = NSIndexPath(forRow: $0, inSection: 0)
                        return tableView.cellForRowAtIndexPath(path)?.textLabel?.text
                    }
                    let texts = { (0 ..< tableView.numberOfRowsInSection(0)).map(textAt) }
                    
                    expect(texts()).to(equal([
                        "0: foo",
                        "1: bar",
                        "2: baz"
                    ]))
                    
                    items.value = ["hoge", "piyo"]
                    
                    expect(texts()).to(equal([
                        "0: hoge",
                        "1: piyo"
                    ]))
                }
            }
        }
    }
}
