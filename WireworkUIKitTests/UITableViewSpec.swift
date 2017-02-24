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
                    
                    let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
                    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                    
                    let items = Variable(["foo", "bar", "baz"])
                    items.bindTo(tableView.wwRows("cell") { row, elem, cell in
                        cell.textLabel?.text = "\(row): \(elem)"
                    }).addTo(bag)
                    
                    let textAt: (Int) -> String? = {
                        let path = IndexPath(row: $0, section: 0)
                        return tableView.cellForRow(at: path)?.textLabel?.text
                    }
                    let texts = { (0 ..< tableView.numberOfRows(inSection: 0)).map(textAt) }
                    
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
