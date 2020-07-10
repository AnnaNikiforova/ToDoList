//
//  TaskModel.swift
//  ToDoList
//
//  Created by Анна Никифорова on 02.07.2020.
//  Copyright © 2020 Анна Никифорова. All rights reserved.
//

import UIKit
import RealmSwift

class TaskModel: Object {
    @objc dynamic var task = ""
    @objc dynamic var completed = false
}
