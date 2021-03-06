//
//  DataModel.swift
//  Checklists
//
//  Created by Sergey Medvedev on 20.07.2021.
//

import Foundation

class DataModel {
    var lists = [Checklist]()
    var indexOfSelectedChecklist: Int {
        get {
            return UserDefaults.standard.integer(forKey: "ChecklistIndex")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "ChecklistIndex")
        }
    }
    
    func documentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
    func dataFilePath() -> URL {
            return documentsDirectory().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklists() {

        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(lists)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }
    
    func loadChecklists() {

        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                lists = try decoder.decode([Checklist].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }
    
    func registerDefaults() {
        
        let dictionary = [ "ChechlistIndex": -1, "FirstTime": true ]  as [String: Any]
        UserDefaults.standard.register(defaults: dictionary)
        
        
    }
    
    func handleFirsttime() {
        let userDefaults = UserDefaults.standard
        let firsttime = userDefaults.bool(forKey: "FirstTime")
        
        if firsttime {
            let checklist = Checklist(name: "List")
            lists.append(checklist)
            
            indexOfSelectedChecklist = 0
            userDefaults.set(false, forKey: "FirstTime")
        }
    }
    
    init() {
        loadChecklists()
        registerDefaults()
        handleFirsttime()
    }
    
}
