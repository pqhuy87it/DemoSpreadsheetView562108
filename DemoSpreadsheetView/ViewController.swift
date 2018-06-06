//
//  ViewController.swift
//  DemoSpreadsheetView
//
//  Created by Pham Quang Huy on 6/5/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import UIKit
import SpreadsheetView

class ViewController: UIViewController, SpreadsheetViewDataSource, SpreadsheetViewDelegate {

    @IBOutlet weak var spreadsheetView:SpreadsheetView!
    
    let weeks = ["Week #14", "Week #15", "Week #16", "Week #17", "Week #18", "Week #19", "Week #20"]
    // Task, Start, Duration, Color
    let projects = [
        Project(name: "Todo リスト（２）", isCollapsed: false, task: [
            Task(data: "約束", startDate: 1, endDate: 4, colorCode: 0),
            Task(data: "名前", startDate: 3, endDate: 6, colorCode: 1)]),
        Project(name: "Doing 中（１２）", isCollapsed: false, task: [
            Task(data: "弁当", startDate: 4, endDate: 10, colorCode: 2),
            Task(data: "自転車", startDate: 3, endDate: 9, colorCode: 1),
            Task(data: "自動車", startDate: 3, endDate: 5, colorCode: 0)]),
        Project(name: "Todo リスト（４）", isCollapsed: false, task: [
            Task(data: "喫茶店", startDate: 4, endDate: 8, colorCode: 1),
            Task(data: "用事", startDate: 3, endDate: 10, colorCode: 2),
            Task(data: "約束", startDate: 1, endDate: 4, colorCode: 2),
            Task(data: "名前", startDate: 5, endDate: 10, colorCode: 0)]),
        Project(name: "Todo リスト（３）", isCollapsed: false, task: [
            Task(data: "喫茶店", startDate: 1, endDate: 12, colorCode: 1),
            Task(data: "牛丼", startDate: 5, endDate: 13, colorCode: 2),
            Task(data: "用事", startDate: 8, endDate: 10, colorCode: 0),
            Task(data: "約束", startDate: 3, endDate: 10, colorCode: 1),
            Task(data: "名前", startDate: 5, endDate: 10, colorCode: 0)])
    ]
    let colors = [UIColor(red: 0.314, green: 0.698, blue: 0.337, alpha: 1),
                  UIColor(red: 1.000, green: 0.718, blue: 0.298, alpha: 1),
                  UIColor(red: 0.180, green: 0.671, blue: 0.796, alpha: 1)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spreadsheetView.dataSource = self
        spreadsheetView.delegate = self
        
        let hairline = 1 / UIScreen.main.scale
        spreadsheetView.intercellSpacing = CGSize(width: hairline, height: hairline)
        spreadsheetView.gridStyle = .solid(width: hairline, color: .lightGray)
        
        spreadsheetView.register(HeaderCell.self, forCellWithReuseIdentifier: String(describing: HeaderCell.self))
        spreadsheetView.register(TextCell.self, forCellWithReuseIdentifier: String(describing: TextCell.self))
        spreadsheetView.register(TaskCell.self, forCellWithReuseIdentifier: String(describing: TaskCell.self))
        spreadsheetView.register(ChartBarCell.self, forCellWithReuseIdentifier: String(describing: ChartBarCell.self))
        spreadsheetView.register(ProjectCell.self, forCellWithReuseIdentifier: String(describing: ProjectCell.self))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spreadsheetView.flashScrollIndicators()
    }
    
    // MARK: DataSource
    
    func numberOfColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1 + 7 * weeks.count
    }
    
    func numberOfRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 2 + self.getTaskCount()
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, widthForColumn column: Int) -> CGFloat {
        if case 0 = column {
            return 90
        } else if case 1...2 = column {
            return 50
        } else {
            return 50
        }
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, heightForRow row: Int) -> CGFloat {
        if case 0...1 = row {
            return 28
        } else {
            return 34
        }
    }
    
    func frozenColumns(in spreadsheetView: SpreadsheetView) -> Int {
        return 1
    }
    
    func frozenRows(in spreadsheetView: SpreadsheetView) -> Int {
        return 2
    }
    
    func mergedCells(in spreadsheetView: SpreadsheetView) -> [CellRange] {
        let titleHeader = [CellRange(from: (0, 0), to: (1, 0))]
        let weakHeader = weeks.enumerated().map { (index, _) -> CellRange in
            return CellRange(from: (0, index * 7 + 1), to: (0, index * 7 + 7))
        }
        
        var taskCellRange = [CellRange]()
        let projectIndexList = self.getProjectIndex()
        
        for (index, project) in projects.enumerated() {
            let projectIndex = projectIndexList[index] + 1
            
            if !project.isCollapsed {
                for (taskIndex, task) in project.task.enumerated() {
                    let cellRange = CellRange(from: (taskIndex + projectIndex + 2, task.startDate + 2), to: (taskIndex + projectIndex + 2, task.endDate + 2))
                    taskCellRange.append(cellRange)
                }
            }
        }
        
        return titleHeader + weakHeader + taskCellRange
    }
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, cellForItemAt indexPath: IndexPath) -> Cell? {
        switch (indexPath.column, indexPath.row) {
        case (0, 0):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = "Task"
            cell.gridlines.left = .default
            cell.gridlines.right = .none
            return cell
        case (1..<(1 + 7 * weeks.count), 0):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = weeks[(indexPath.column - 1) / 7]
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
        case (1..<(1 + 7 * weeks.count), 1):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: HeaderCell.self), for: indexPath) as! HeaderCell
            cell.label.text = String(format: "%02d Apr", indexPath.column)
            cell.gridlines.left = .default
            cell.gridlines.right = .default
            return cell
        // ten task
        case (0, 2..<(2 + self.getTaskCount())):
            let projectIndexList = self.getProjectIndex()
            
            if projectIndexList.contains(indexPath.row - 2) {
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ProjectCell.self), for: indexPath) as! ProjectCell
                let project = self.getProject(indexPath: indexPath)!
                cell.label.text = project.name
                cell.gridlines.left = .default
                cell.gridlines.right = .none
                cell.delegate = self
                return cell
            } else {
                let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell
                if let task = self.getTask(indexPath: indexPath) {
                    cell.label.text = task.data
                }
                
                cell.gridlines.left = .default
                cell.gridlines.right = .none
                return cell
            }

        case (1..<(1 + 7 * weeks.count), 2..<(2 + self.getTaskCount())):
            let cell = spreadsheetView.dequeueReusableCell(withReuseIdentifier: String(describing: ChartBarCell.self), for: indexPath) as! ChartBarCell
            let projectIndexList = self.getProjectIndex()
            
            if !projectIndexList.contains(indexPath.row - 2) {
                let task = self.getTask(indexPath: indexPath)
                let start = task?.startDate
                
                if start == indexPath.column - 2 {
                    cell.label.text = task?.data
                    let colorIndex = task?.colorCode
                    cell.color = colors[colorIndex!]
                } else {
                    cell.label.text = ""
                    cell.color = .clear
                }
            } else {
                cell.label.text = ""
                cell.color = .clear
            }
            return cell
        default:
            return nil
        }
    }
    
    /// Delegate
    
    func spreadsheetView(_ spreadsheetView: SpreadsheetView, didSelectItemAt indexPath: IndexPath) {
        print("Selected: (row: \(indexPath.row), column: \(indexPath.column))")
        let index = indexPath.row - 2
        
        let taskIndex = self.getProjectIndex()
        
        let i = taskIndex.index(of: index)
        let task = self.projects[i!]
        task.isCollapsed = !task.isCollapsed
        self.spreadsheetView.reloadData()
    }
    
    func getProjectIndex() -> [Int] {
        var arrIndex: [Int] = []
        var startIndex = 0
        
        for (index, task) in self.projects.enumerated() {
            if index == 0 {
                arrIndex.append(index)
            } else {
                arrIndex.append(startIndex)
            }
            
            startIndex += (task.isCollapsed ? 1 : task.task.count + 1)
        }
        
        return arrIndex
    }
    
    func getTaskCount() -> Int {
        var count = 0
        
        for project in self.projects {
            count += 1 + (project.isCollapsed ? 0 : project.task.count)
        }
        
        return count
    }
    
    func getProject(indexPath: IndexPath) -> Project? {
        let realIndex = indexPath.row - 2
        let projectIndex = self.getProjectIndex()
        
        let index = projectIndex.index(of: realIndex)!
        return self.projects[index]
    }
    
    func getTask(indexPath: IndexPath) -> Task? {
        let projectIndex = self.getProjectIndex()
        let realIndex = indexPath.row - 2
        
        for (i, index) in projectIndex.enumerated() {
            if i + 1 < projectIndex.count {
                if projectIndex[i+1] > realIndex {
                    let project = self.projects[i]
                    
                    return project.task[realIndex - index - 1]
                }
            } else if i == projectIndex.count - 1 {
                let project = self.projects[i]
                return project.task[realIndex - index - 1]
            }
        }
        
        return nil
    }
}

extension ViewController: ProjectCellDelegate {
    func didExpandCollapseProject(indexPath: IndexPath) {
        
    }
}
