
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    
    var downloadedData: [DataNews.Article]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        updataTableView()
        setСolor()
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(addButtonTapped))
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(noName),
            name: Notification.Name("updataTableView"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            forName: Notification.Name("SwitchTheme"),
            object: nil,
            queue: .main) { Notification in
                self.setСolor()
            }
        
    }
    
    func setСolor() {
        if UserDefaults.standard.bool(forKey: Constants.switchKey) {
            self.view.backgroundColor = .black
        } else {
            self.view.backgroundColor = .white

        }
    }
    
    @objc  func addButtonTapped () {
        
        let storyBord = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBord.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func updataTableView(){
        apiNews.shared.fetchNews { result in
            
            switch result {
            case .success(let data):
                DispatchQueue.main.async{ [weak self] in
                    guard let self = self else {return}
                    downloadedData = data.articles
                    tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func noName() {
        updataTableView()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        let title = UserDefaults.standard.string(forKey: "reguest")
        
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        downloadedData?.count ?? 0 // 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
                
        guard let urlString = downloadedData[indexPath.row].urlToImage, let url = URL(string: urlString)  else {
            cell.ImageInCell.image = UIImage(named: "noImage")
            return cell
        }
        
        DispatchQueue.global().async {
            let dataImage = try? Data(contentsOf:url)
            
            if let data = dataImage {
                let image = UIImage(data: data)
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
                    let date = dateFormatter.date(from: downloadedData[indexPath.row].publishedAt)
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    cell.ImageInCell.image = image
                    cell.autorLabel.text = downloadedData[indexPath.row].author
                    cell.titleLabel.text = downloadedData[indexPath.row].title
                    cell.dateLabel.text = dateFormatter.string(from: date!)
   
                }
                
            } else {
                DispatchQueue.main.async {
                    cell.ImageInCell.image = UIImage(named: "noImage")
                }
            }
            
        }
        
        
        
        // guard let url = URL(string: imageString) else {return}
        
        
        return cell
    }
    
}

