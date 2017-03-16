//
//  Note.swift
//  TodoNote
//
//  Copyright (c) 2014 TodoNote. All rights reserved.
//

import Foundation

class Note : NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date() // Defaults to current date / time
    var deadline = ""
    
    // Computed property to return date as a string
    var shortDate : NSString {
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yy"
            return dateFormatter.string(from: self.date) as NSString
    }
    
    override init() {
        super.init()
    }
    
    // 1: Encode ourselves...
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(text, forKey: "text")
        aCoder.encode(date, forKey: "date")
        //aCoder.encode(deadline, forKey: "deadline")
    }
    
    // 2: Decode ourselves on init
    required init(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: "title") as! String
        self.text  = aDecoder.decodeObject(forKey: "text") as! String
        self.date   = aDecoder.decodeObject(forKey: "date") as! Date
        //self.deadline  = aDecoder.decodeObject(forKey: "deadline") as! String
    }
    
}
