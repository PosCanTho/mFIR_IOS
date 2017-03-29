//
//  SettingsController.swift
//  mFIR
//
//  Created by lehoangdung on 3/25/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import UIKit

class SettingsController: UIViewController{
    //MARK: ****** Data Model
    
    //MARK: **** UI Element
    @IBOutlet weak var swLang: UISwitch!
    @IBOutlet weak var swSysn: UISwitch!
    @IBOutlet weak var lblLang: LocalizableLabel!
    @IBOutlet weak var lblSync: LocalizableLabel!
    var currentLocale = Prefs.shared.currentLocale()
    
    
    
    //MARK: *** UI Action
    @IBAction func swLang(_ sender: UISwitch) {
        if let sw = sender as? UISwitch
        {
            if sw.isOn
            {
                Prefs.set(key: "swSettingsLang", value: 1)
                Prefs.shared.setCurrentLocale(LangEN)
                view.onUpdateLocale()
                self.view.onUpdateLocale()
            }else{
                Prefs.set(key: "swSettingsLang", value: 0)
                Prefs.shared.setCurrentLocale(LangVI)
                view.onUpdateLocale()
                self.view.onUpdateLocale()
            }
            
//            print(Prefs.shared.currentLocale())
            
        }
    }
    
    
    
    //MARK: UI Events
    
    //MARK: UI Controller
    override func viewDidLoad() {
        super.viewDidLoad()
        addSideMenu()
//        print(currentLocale)
        let swlang = Prefs.get(key: "swSettingsLang") as? Int
        
        if swlang == nil
        {
            Prefs.set(key: "swSettingsLang", value: 1)
            swLang.setOn(true, animated: true)
//            print("Vào lần đầu mặc định tiếng anh")
        }else if(swlang == 1){
            swLang.setOn(true, animated: true)
//            print("Tiếng anh")
        }else if(swlang == 0){
            swLang.setOn(false, animated: true)
//            print("Tiếng Việt")
        }
        
    }
    
}
