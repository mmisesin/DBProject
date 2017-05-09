//
//  LoginVC.swift
//  DBProject
//
//  Created by Artem Misesin on 2/28/17.
//  Copyright © 2017 Artem Misesin. All rights reserved.
//

import Cocoa

class LoginVC: NSViewController, DBQueries {

    @IBOutlet weak var mailField: NSTextField!
    
    @IBOutlet weak var passField: NSSecureTextField!
    
    @IBOutlet weak var errorLabel: NSTextField!
    
    var result = ""
    
    @IBOutlet weak var saveLoginCB: NSButton!
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if identifier == "register"{
            return true
        } else {
            result = auth(mail: mailField.stringValue, pass: passField.stringValue)
            if result == "tuplesOK"{
                return true
            } else {
                errorLabel.stringValue = "Incorrect e-mail or password"
                return false
            }
        }
    }
    
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        if result == "tuplesOK"{
            let defaults = UserDefaults.standard
            if saveLoginCB.state == NSOnState {
                defaults.setValue(true, forKey: "saveLogin")
                defaults.setValue(mailField.stringValue, forKey: "mail")
                defaults.setValue(passField.stringValue, forKey: "pass")
            } else {
                defaults.setValue(false, forKey: "saveLogin")
            }
        }
        print(LoggedUser.shared.type!)
        print(LoggedUser.shared.iD)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //presentViewControllerAsModalWindow(self)
        errorLabel.sizeToFit()
        // Do view setup here.
        let defaults = UserDefaults.standard
        let saveLogin = defaults.value(forKey: "saveLogin") as? Bool
        saveLoginCB.state = NSOffState
        if let save = saveLogin, save {
            saveLoginCB.state = NSOnState
            mailField.stringValue = defaults.value(forKey: "mail") as! String
            passField.stringValue = defaults.value(forKey: "pass") as! String
        }
        
    }
}
