//
//  TableViewController.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/13.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import Foundation
import UIKit


class TableViewController: UITableViewController {
    
    
    
    @IBOutlet var namesTableView: UITableView!
    
    
    var people = [StudentInformation] ()
    var indicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        indicator = UIActivityIndicatorView (style: UIActivityIndicatorView.Style.medium)
        self.view.addSubview(indicator)
        indicator.bringSubviewToFront(self.view)
        indicator.center = self.view.center
        showActivityIndicator()
        super.viewDidLoad()
    }
    
    //Table View//
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath)
        let student = people[indexPath.row]
        cell.textLabel?.text = "\(student.firstName)" + " " + "\(student.lastName)"
        cell.detailTextLabel?.text = "\(student.mediaURL ?? "")"
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexpath: IndexPath) {
        let student = people[indexpath.row]
        openLink(student.mediaURL ?? "")
    }
        
        func showActivityIndicator() {
            indicator.isHidden = false
            indicator.startAnimating()
        }
        
        func hideActivityIndicator() {
            indicator.isHidden = true
            indicator.stopAnimating()
        }
        
}
