//
//  Database.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 27.10.2021.
//

import Foundation
import CoreData

class Database {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Task12StorageMethods_main_")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("An error ocurred while saving: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Create
    
    func createFolder(name: String, folderDescription: String){
        let folder = Folder(context: persistentContainer.viewContext)
        
        try? persistentContainer.viewContext.obtainPermanentIDs(for: [folder])
        
        folder.name = name
        folder.folderDescription = folderDescription
        folder.creationDate = Date()
        
        saveContext()
    }
    
    func createNote(name: String, stringContent: String) -> Note {
        let note = Note(context: persistentContainer.viewContext)
        
        try? persistentContainer.viewContext.obtainPermanentIDs(for: [note])
        
        note.name = name
        note.stringContent = stringContent
        note.creationDate = Date()
        
        saveContext()
        
        return note
    }
    
    func createModification() -> Modification {
        let modification = Modification(context: persistentContainer.viewContext)
        
        try? persistentContainer.viewContext.obtainPermanentIDs(for: [modification])
        
        modification.date = Date()
        
        saveContext()
        
        return modification
    }
    
    // MARK: - Delete
    
    func deleteItem<T: NSManagedObject>(item: T) {
        persistentContainer.viewContext.delete(item)
        saveContext()
    }
}
