//
//  ViewController.swift
//  ToDoList
//
//  Created by Анна Никифорова on 26.06.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit
import RealmSwift

class TasksListVC: UIViewController {
    
    let realm = try! Realm()
    var tasks: Results<TaskModel>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTaskTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addButton.layer.cornerRadius = 20
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        tasks = realm.objects(TaskModel.self)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        insertNewTask()
    }
    
    func insertNewTask() {
        let tasks = TaskModel()
        let indexPath = IndexPath(row: tasks.task.count - 1, section: 0)
        
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tasks.task.append(addTaskTextField.text!)
        addTaskTextField.text = ""
        
        try! self.realm.write {
            self.realm.add(tasks)
        }
        
        tableView.endUpdates()
        view.endEditing(true)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension TasksListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tasks.count != 0 {
            return tasks.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        let taskTitle = tasks[indexPath.row]
        cell.taskLabel.text = taskTitle.task
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let editingRow = tasks[indexPath.row]
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            try! self.realm.write {
                self.realm.delete(editingRow)
            }
        
            tableView.endUpdates()
        }
    }
    
}

