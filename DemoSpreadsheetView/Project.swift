//
//  Task.swift
//  DemoSpreadsheetView
//
//  Created by Pham Quang Huy on 6/5/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation

class Project {
    var name: String
    var isCollapsed: Bool
    var task: [Task]
    
    init(name: String, isCollapsed: Bool, task: [Task]) {
        self.name = name
        self.isCollapsed = isCollapsed
        self.task = task
    }
}

class Task {
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
