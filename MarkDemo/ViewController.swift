//
//  ViewController.swift
//  MarkDemo
//
//  Created by Alex wee on 2021/1/29.
//

import UIKit
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    
    lazy var tabView:UITableView = {
        let tab = UITableView(frame: self.view.bounds, style: .plain)
        tab.register(MardDownCell.self, forCellReuseIdentifier: "cell")
        tab.delegate = self
        tab.dataSource = self
        return tab
    }()
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tabView)
        tabView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tabView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tabView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    //  MARK: - TableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MardDownCell
        cell.configModel()
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    


}

