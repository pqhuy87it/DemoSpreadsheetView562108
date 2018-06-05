//
//  Task.swift
//  DemoSpreadsheetView
//
//  Created by Pham Quang Huy on 6/5/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

class Task {
    var name: String = "abc"
    var isCollapsed: Bool = false
    var taskDetails: [TaskDetail]
    
    init(taskDetails: [TaskDetail]) {
        self.taskDetails = taskDetails
    }
}

class TaskDetail {
    var data: String
    var startDate: Int
    var endDate: Int
    var colorCode: Int
    
    init(data: String, startDate: Int, endDate: Int, colorCode: Int) {
        self.data = data
        self.startDate = startDate
        self.endDate = endDate
        self.colorCode = colorCode
    }
}
