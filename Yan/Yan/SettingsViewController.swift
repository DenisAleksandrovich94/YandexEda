

import UIKit


class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var Switch: UISwitch!
    
    @IBOutlet var reguestTextField: UITextField!
    
    @IBOutlet var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reguestTextField.delegate = self
        
        Switch.addTarget(self, action: #selector(touchInSwitch), for: .valueChanged)
        Switch.setOn(UserDefaults.standard.bool(forKey: "switch"), animated: true)
        
        searchButton.addTarget(self, action: #selector(touchedButton), for: .touchUpInside)
    }
    
    @objc func touchedButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func touchInSwitch() {
        
        UserDefaults.standard.set(Switch.isOn, forKey: Constants.switchKey)
        NotificationCenter.default.post(name: Notification.Name("SwitchTheme"), object: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField){
        
        UserDefaults.standard.set(reguestTextField.text, forKey: "reguest")
        
        NotificationCenter.default.post(name: Notification.Name("updataTableView"), object: nil)

        print(UserDefaults.standard.string(forKey: "reguest"))
    }
}

enum Constants {
    static let switchKey = "switch"
}
