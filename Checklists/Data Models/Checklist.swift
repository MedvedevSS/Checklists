//
//  Checklist.swift
//  Checklists
//
//  Created by Sergey Medvedev on 12.07.2021.
//

import UIKit

class Checklist: NSObject, Codable {
    
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
}
