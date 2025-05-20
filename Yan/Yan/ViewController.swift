//
//  ViewController.swift
//  Yan
//
//  Created by Ivakhnenko Denis on 20.05.2025.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var TableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.dataSource = self
        apiNews.shared.fetchNews { result in
            switch result {
            case .success(let data):
                print(data)
                
            case .failure(let error):
                print(error)
            }
            
        }
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
       
        return cell
    }
    
}

