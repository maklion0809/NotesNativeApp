//
//  NotePresenter.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import Foundation
import CoreData

final class NotePresenter {
    weak var coordinatorDelegate: NoteCoordinatorDelegate?
    lazy var fetchResultController: NSFetchedResultsController<Note> = {
        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "folder == %@", self.model.folder)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let fetchResultController: NSFetchedResultsController<Note> = .init(fetchRequest: fetchRequest, managedObjectContext: database.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        return fetchResultController
    }()
    private let model: NoteModel
    private let database: Database
    
    init(model: NoteModel, database: Database) {
        self.model = model
        self.database = database
    }
    
    // MARK: - Navigation
    
    func handleCreateNoteButtonAction() {
        coordinatorDelegate?.userInitiatedCreatorNote(folder: model.folder, note: nil, state: .insert)
    }
    
    func handleUpdateNoteButtonAction(for note: Note) {
        coordinatorDelegate?.userInitiatedCreatorNote(folder: model.folder, note: note, state: .update)
    }
    
    // MARK: - Core data
    
    func handleCoreData() {
        do {
            try fetchResultController.performFetch()
        } catch {
            print("")
        }
    }
    
    // MARK: - Delete
    
    func handleDeleteItem(note: Note) {
        self.database.deleteItem(item: note)
    }
    
    // MARK: - Sorting
    
    func handleSortItems(by category: String, ascending: Bool) {
        fetchResultController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: category, ascending: ascending)]
        do {
            try fetchResultController.performFetch()
        } catch {
            print("")
        }
    }
    
    // MARK: - Data source TableView
    
    var numberOfSections: Int {
        fetchResultController.sections?.count ?? .zero
    }
    
    func numberOfRows(in section: Int) -> Int? {
        fetchResultController.sections?[section].objects?.count
    }
    
    func getObject(at indexPath: IndexPath) -> Note? {
        fetchResultController.object(at: indexPath)
    }
}
