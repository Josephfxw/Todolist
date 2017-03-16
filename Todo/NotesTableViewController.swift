//
//  NotesTableViewController.swift
//  TodoNote
//
//  Copyright (c) 2014 TodoNote. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController,  UISearchDisplayDelegate  {
    
   
    @IBOutlet weak var taskNum: UILabel!
   // @IBOutlet var tableView: UITableView!
    var filteredTodos: [Note] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Leverage the built in TableViewController Edit button
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")// i add
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ensure we are not in edit mode
        isEditing = false
        
        //display the total number of tasks
        taskNum.text = String (describing: NoteStore.sharedNoteStore.count()) + " tasks"

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Here we pass the note they tapped on between the view controllers
        if segue.identifier == "NoteDetailPush" {
            // Get the controller we are going to
            let noteDetail = segue.destination as! NoteDetailViewController
            // Lookup the data we want to pass
            let theCell = sender as! NoteDetailTableViewCell
            // Pass the data forward
            noteDetail.theNote = theCell.theNote
        }
    }
    
    
    @IBAction func saveFromNoteDetail(_ segue:UIStoryboardSegue) {
        // We come here from an exit segue when they hit save on the detail screen
        
        // Get the controller we are coming from
        var noteDetail = segue.source as! NoteDetailViewController
        
        // If there is a row selected....
        if let indexPath = tableView.indexPathForSelectedRow {
            // Update note in our store
            NoteStore.sharedNoteStore.updateNote(_theNote: noteDetail.theNote)
            
            // The user was in edit mode
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        } else {
            // Otherwise, add a new record
            NoteStore.sharedNoteStore.createNote(noteDetail.theNote)
            
            // Get an index to insert the row at
            var indexPath = IndexPath(row: NoteStore.sharedNoteStore.count()-1, section: 0)
            
            // Update tableview
            tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Just return the note count
        
        
        if tableView == searchDisplayController?.searchResultsTableView {
            return filteredTodos.count
        }
        else {
            return NoteStore.sharedNoteStore.count()
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a reusable cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteDetailTableViewCell", for: indexPath) as! NoteDetailTableViewCell
        
        // Fetch the note
        let rowNumber = indexPath.row
        var theNote:Note!
        if tableView == searchDisplayController?.searchResultsTableView {
             theNote = filteredTodos[rowNumber]
        }
        else {
            theNote = NoteStore.sharedNoteStore.getNote(rowNumber)
        }
        
        
        
        // Configure the cell
        cell.setupCell(theNote)
        
        return cell
        
        
      
    }
    
    // Search the Cell
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        //filteredTodos = todos.filter({( todo: Task) -> Bool in
        //    let stringMatch = todo.title.rangeOfString(searchString)
        //    return stringMatch != nil
        //})
        
        // Same as below
        filteredTodos = NoteStore.sharedNoteStore.SearchedNote(Searchtring: searchString! )
        return true
    }

    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            // Delete the row from the data source
            NoteStore.sharedNoteStore.deleteNote(indexPath.row)
            // Delete the note from the tableview
            tableView.deleteRows(at: [indexPath], with: .fade)
            taskNum.text = String (describing: NoteStore.sharedNoteStore.count()) + " tasks"
        }
    }
    
    
}
