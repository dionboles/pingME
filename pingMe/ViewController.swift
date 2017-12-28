//
//  ViewController.swift
//  pingMe
//
//  Created by Dion Boles on 12/27/17.
//  Copyright © 2017 Dion Boles. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,TableViewCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    var ToDoItems = [ToDoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 50.0
        tableView.backgroundColor = UIColor.black
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell");
        if ToDoItems.count > 0{
            return
        }
        ToDoItems.append(ToDoItem(text:"test"));
        ToDoItems.append(ToDoItem(text:"do some thing"));
        ToDoItems.append(ToDoItem(text:"good cry "));
        ToDoItems.append(ToDoItem(text:"good job "));
        ToDoItems.append(ToDoItem(text:"why "));
        ToDoItems.append(ToDoItem(text:"what "));
        // Do any additional setup after loading the view, typically from a nib.
    }
    func colorForIndex(index: Int)->UIColor{
        let itemCount = ToDoItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount))*0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    func toDoItemDeleted(todoItem toDoItem: ToDoItem) {
        var index = 0
        for i in 0..<ToDoItems.count{
            if ToDoItems[i] == toDoItem{
                index = i
                break
            }
        }
        ToDoItems.remove(at: index)
        let visibleCells = tableView.visibleCells as! [TableViewCell]
        let lastView = visibleCells[visibleCells.count - 1]
        var delay = 0.0
        var startAnimating = false
        let listCount = visibleCells.count
        for i in 0..<listCount {
                let cell = visibleCells[i]
                    if startAnimating{
                        UIView.animate(withDuration: 0.3, animations: {
                            
                        })
                    }
        tableView.beginUpdates()
        let indexPathForRow = IndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPathForRow], with: .fade)
        tableView.endUpdates()
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    private func tableView(tableView: UITableView, heightForRowAtIndexPath
        indexPath: IndexPath) -> CGFloat {
        return tableView.rowHeight;
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoItems.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let item = ToDoItems[indexPath.row]
        cell.delegate = self;
        cell.toDoItem = item;
        cell.selectionStyle = .none
        cell.textLabel?.text = item.text
        cell.textLabel?.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.white
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

