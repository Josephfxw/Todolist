//
//  NoteDetailViewController.swift
//  TodoNote
//
//  Copyright (c) 2014 TodoNote. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController ,UITextFieldDelegate{
    
    var theNote = Note()
    
  
    
    @IBOutlet weak var noteTitleLabel: UITextField!
    
    @IBOutlet weak var noteTextView: UITextView!
    
    @IBOutlet weak var deadline: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The view starts here. By now we either have a note to edit
        // or we have a blank note in theNote property we can use
        
        // Update the screen with the contents of theNote
        self.noteTitleLabel.text = theNote.title
        self.noteTextView.text = theNote.text
        
        // Set the Cursor in the note text area
        self.noteTextView.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Whenever we leave the screen, update our note model
        theNote.title = self.noteTitleLabel.text!
        theNote.text = self.noteTextView.text!
        //theNote.deadline = String(describing: deadline.date)
       
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        theNote.deadline = dateFormatter.string(from: deadline.date)
        
 
      
        
    }
    
  
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
