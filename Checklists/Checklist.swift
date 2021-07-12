//
//  Checklist.swift
//  Checklists
//
//  Created by Sergey Medvedev on 12.07.2021.
//

import UIKit

class Checklist: NSObject {
    
    var name = ""
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
