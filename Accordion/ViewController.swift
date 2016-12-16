//
//  ViewController.swift
//  Accordion
//
//  Created by asirotenko on 11/16/16.
//  Copyright © 2016 asirotenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private let estimatedRowHeight:CGFloat = 150
    
    private let headerHeight:CGFloat = 40.0;
    
    private let headerBackgroundColor = UIColor.lightGray
    
    private var customCells: CustomCells?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.customCells?.sections.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.customCells!.getRowsForSection(section: section)
    }
    
    override func viewDidLoad() {
        self.customCells = CustomCells()
        self.fetchFaq()
        self.tableView.estimatedRowHeight = self.estimatedRowHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorColor = UIColor.lightGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.items?[0].title = ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = (self.customCells?.getCell(section: indexPath.section, row: indexPath.row))!
        let label = item.label
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as? CustomCell
            else { fatalError("Failed to dequeue a customCell.") }
        
        cell.customLabel.text = label
        cell.customText.text = item.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = self.customCells?.getCell(section: indexPath.section, row: indexPath.row)
        
        if ((item?.isVisible)!) {
            return UITableViewAutomaticDimension
        } else {
            return 0
        }
    }
    
    //TODO: reuse header section object
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = Bundle.main.loadNibNamed("TableSectionHeader", owner: nil, options: nil)?.first as! SectionHeader        
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.onHeaderTap(gestureRecognizer:)))
        tapRecognizer.numberOfTapsRequired = 1
        tapRecognizer.numberOfTouchesRequired = 1
        headerView.addGestureRecognizer(tapRecognizer)
        headerView.tag = section
        let header = (self.customCells?.getHeader(section: section))!
        
        
        headerView.titleLabel.text = header.label
        headerView.toggleSectionArrow(sectionIsVisible: (self.customCells?.sectionIsVisible(section: section))!)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    func onHeaderTap(gestureRecognizer: UIGestureRecognizer)
    {
        guard let cell = gestureRecognizer.view as? UITableViewHeaderFooterView else {
            return
        }
        
        let section = cell.tag
        self.customCells?.toggleGroup(expand:!self.customCells!.sectionIsVisisble(section: section), section: section)
        self.tableView.beginUpdates()
        self.tableView.reloadSections([section], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func fetchFaq(){
        self.customCells?.addHeader(label: "General")
        self.customCells?.addCell(label: "What is this widget based on?", text: "Accordion is based on tableView class")
        
        self.customCells?.addCell(label: "How can I use Accordion widget?", text: "It is possible to modify some data source or widget itself. You are also welcome to contribute to my repo.")
        
        self.customCells?.addCell(label: "How can I use dynamic data?", text: "You can modify fetchData method to request data from anywhere you like.")
        
        self.customCells?.addHeader(label: "Future features")
        self.customCells?.addCell(label: "Will Accordion be supported?", text: "All questions and pullrequest will be considered as well as feature requests.")
        
        self.customCells?.addHeader(label: "Contributing")
        self.customCells?.addCell(label: "How can I contribute?", text: "All pull request and feature requests will be considered.")
    }
}


