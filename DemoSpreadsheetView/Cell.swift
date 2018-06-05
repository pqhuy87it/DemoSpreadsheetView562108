//
//  Cell.swift
//  DemoSpreadsheetView
//
//  Created by Pham Quang Huy on 6/5/18.
//  Copyright © 2018 Pham Quang Huy. All rights reserved.
//

import Foundation
import SpreadsheetView

class HeaderCell: Cell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TextCell: Cell {
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class TaskCell: Cell {
    let label = UILabel()
    
    override var frame: CGRect {
        didSet {
            label.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ProjectCell: Cell {
    let button = UIButton()
    
    override var frame: CGRect {
        didSet {
            button.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        button.frame = bounds
        button.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        button.font = UIFont.boldSystemFont(ofSize: 10)
//        button.textAlignment = .left
        
        contentView.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class ChartBarCell: Cell {
    let colorBarView = UIView()
    let label = UILabel()
    
    var color: UIColor = .clear {
        didSet {
            colorBarView.backgroundColor = color
        }
    }
    
    override var frame: CGRect {
        didSet {
            colorBarView.frame = bounds.insetBy(dx: 2, dy: 2)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(colorBarView)
        
        label.frame = bounds
        label.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .white
        
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
