//
//  NoteTableViewCell.swift
//  TodoNote
//
//  Copyright (c) 2014 TodoNote. All rights reserved.
//

import UIKit

class NoteDetailTableViewCell : UITableViewCell {
    
    // The note currently being shown
    weak var theNote : Note!
    
    // Interface builder outlets
    @IBOutlet weak var noteTitleLabel : UILabel!
    @IBOutlet weak var noteDateLabel : UILabel!
    @IBOutlet weak var noteTextLabel : UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    
    // Insert note contents into the cell
    func setupCell(_ theNote:Note) {
        // Save a weak reference to the note
        self.theNote = theNote
        
        // Update the cell
        noteTitleLabel.text = theNote.title
        noteTextLabel.text = theNote.text
        noteDateLabel.text = theNote.shortDate as String
        deadlineLabel.text = theNote.deadline
    }
    
}
