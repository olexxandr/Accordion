//
//  CustomCell.swift
//  Accordion
//
//  Created by asirotenko on 11/16/16.
//  Copyright © 2016 asirotenko. All rights reserved.
//

import UIKit

class Cell {
    
    var isVisible: Bool!
    
    var label: String!
    
    init(isVisible: Bool, label: String) {
        self.isVisible = isVisible
        self.label = label
    }
}

class TableViewHeader_faq : Cell {
    
    init(label: String) {
        super.init(isVisible: true, label: label)
    }
}

class TableViewCell_faq : Cell  {
    
    var text: String!
    
    init(isVisible:Bool, label: String, text: String) {
        super.init(isVisible: isVisible, label: label)
        self.text = text
    }
    
    func expand() {
        self.toogleVisible(isVisible: true)
    }
    
    func collapse() {
        self.toogleVisible(isVisible: false)
    }
    
    func toogleVisible(isVisible: Bool) {
        self.isVisible = isVisible
    }
}

class Section {
    
    var cells: [Cell] = []
    
    var numOfCells: Int = 0
    
    private var _isVisisble: Bool = true
    
    var isVisible: Bool {
        get {
            return _isVisisble
        }
        set {
            _isVisisble = newValue
        }
    }
    
    func addHeader(label:String){
        self.cells.append(TableViewHeader_faq(label: label))
    }
    
    func addCell(label:String, text: String) {
        self.cells.append(TableViewCell_faq(isVisible: true, label: label, text: text))
        numOfCells += 1
    }
    
    func toggleSection(expand:Bool){
        for cell in self.cells {
            if (!(cell is TableViewHeader_faq)) {
                cell.isVisible = expand
            }
        }
        isVisible = expand;
    }
    
    func getCells () -> [TableViewCell_faq]? {
        return self.cells.flatMap() { $0 as? TableViewCell_faq }
    }
    
    func getHeader() -> TableViewHeader_faq? {
        var cells = self.cells.filter() {$0 is TableViewHeader_faq}
        
        return cells[0] as? TableViewHeader_faq
    }
    
    func getCell(row: Int) -> TableViewCell_faq? {
        var cells = self.cells.filter() {$0 is TableViewCell_faq}
        
        return cells[row] as? TableViewCell_faq
    }
}

class CustomCells {
    
    var sections:[Section] = []
    
    var cellNumber: Int = 0
    
    func addHeader(label:String){
        let section = Section()
        section.addHeader(label:label)
        self.sections.append(section)
    }
    
    func getRowsForSection(section:Int) -> Int {
        
        return self.sections[section].numOfCells
    }
    
    func addCell(label:String, text:String) {
        let section = self.sections[self.sections.count - 1]
        section.addCell(label:label, text:text)
    }
    
    func toggleGroup(expand:Bool, section: Int){
        self.sections[section].toggleSection(expand: expand)
    }
    
    func sectionIsVisible(section:Int) -> Bool {
        return self.sections[section].isVisible
    }
    
    
    func getCell(section: Int, row: Int) -> TableViewCell_faq? {
        let section = self.sections[section]
        let cells = section.getCells()
        return cells?[row]
    }
    
    func getHeader(section: Int) -> TableViewHeader_faq? {
        let section = self.sections[section];
        
        return section.getHeader()
    }
}

class CustomCell: UITableViewCell {
    @IBOutlet weak var customLabel: UILabel!
    
    @IBOutlet weak var customText: UILabel!
}

