//
//  Prefs.swift
//  mFIR
//
//  Created by lehoangdung on 3/24/17.
//  Copyright © 2017 poscantho. All rights reserved.
//

import Foundation
class Prefs {
    static func set(key:String, value: Any){// Any là kiểu dữ liệu bất kỳ
        UserDefaults.standard.set(value, forKey: key)
    }
    static func get(key:String) -> Any?{
        return UserDefaults.standard.value(forKey: key)
    }
}
