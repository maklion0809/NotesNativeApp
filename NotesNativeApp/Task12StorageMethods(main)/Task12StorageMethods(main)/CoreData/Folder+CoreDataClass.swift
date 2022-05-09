//
//  Folder+CoreDataClass.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//
//

import Foundation
import CoreData

@objc(Folder)
public class Folder: NSManagedObject {
    
    func addNoteInFolder(note: Note) {
        addToNotes(note)
        save()
    }
    
    func deleteNoteInFolder(note: Note) {
        removeFromNotes(note)
        save()
    }
    
    func addModificationsInFolder(modification: Modification) {
        addToModifications(modification)
        save()
    }
    
    func save() {
        do {
            try managedObjectContext?.save()
        } catch {
            
        }
    }
}
