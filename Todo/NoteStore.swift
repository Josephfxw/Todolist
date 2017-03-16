//
//  NoteStore.swift
//  TodoNote
//
//  Copyright (c) 2014 TodoNote. All rights reserved.
//

import Foundation

class NoteStore {
    // Mark: Singleton Pattern (hacked since we don't have class var's yet)
    class var sharedNoteStore : NoteStore {
    struct Static {
        static let instance : NoteStore = NoteStore()
        }
        return Static.instance
    }
    
    // Private init to force usage of singleton
    fileprivate init() {
        load()
    }
    
    // Array to hold our notes
    fileprivate var notes : [Note]!
    
    // CRUD - Create, Read, Update, Delete
    
    // Create
    
    func createNote(_ theNote:Note = Note()) -> Note {
        notes.append(theNote)
        return theNote
    }
    
    
    func SearchedNote(Searchtring: String) -> [Note] {
        var temp : [Note] = []
        for (i, note) in notes.enumerated() {
            if note.title == Searchtring {
              temp.append(getNote(i))
            }
        }
        return temp
    }
    
    
    
    // Read
    
    func getNote(_ index:Int) -> Note {
        return notes[index]
    }
    
    // Update
    func updateNote(_theNote:Note) {
        // Notes passed by reference, no update code needed
    }
    
    // Delete
    func deleteNote(_ index:Int) {
        notes.remove(at: index)
    }
    
    func deleteNote(_ withNote:Note) {
        
        for (i, note) in notes.enumerated() {
            if note === withNote {
                notes.remove(at: i)
                return
            }
        }
        
    }
    
    // Count
    func count() -> Int {
        return notes.count
    }
    
    
    // Mark: Persistence
    
    // 1: Find the file & directory we want to save to...
    func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = NSString(string: paths.first!)
        let path = documentsDirectory.appendingPathComponent("NoteStore.plist")
        
        return path
    }
    
    // 2: Do the save to disk.....
    func save() {
        NSKeyedArchiver.archiveRootObject(notes, toFile: archiveFilePath())
    }
    
    
    // 3: Do the reload from disk....
    func load() {
        let filePath = archiveFilePath()
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: filePath) {
            notes = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [Note]
        } else {
            notes = [Note]()
        }
    }
    
}
