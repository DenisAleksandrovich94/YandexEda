

import UIKit


class SettingsViewController: UIViewController {
        
    @IBOutlet var Switch: UISwitch!
    
    @IBOutlet var reguestTextField: UITextField!
    
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Switch.addTarget(self, action: #selector(touchInSwitch), for: .valueChanged)
        
        
        Switch.setOn(UserDefaults.standard.bool(forKey: "switch"), animated: true)
    }
    
    @objc func touchInSwitch() {
        
        UserDefaults.standard.set(Switch.isOn, forKey: "switch")
        
    }
    
}
