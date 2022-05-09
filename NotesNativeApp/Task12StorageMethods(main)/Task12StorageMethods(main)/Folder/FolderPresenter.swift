//
//  FolderPresenter.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import UIKit
import CoreData

final class FolderPresenter {
    weak var coordinatorDelegate: FolderCoordinatorDelegate?
    lazy var fetchResultController: NSFetchedResultsController<Folder> = {
        let fetchRequest: NSFetchRequest<Folder> = Folder.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        let fetchResultController: NSFetchedResultsController<Folder> = .init(fetchRequest: fetchRequest, managedObjectContext: database.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchResultController
    }()
    private let model: FolderModel
    private let database: Database

    init(model: FolderModel, database: Database) {
        self.model = model
        self.database = database
    }
    
    func handleInfoFolderButtonAction(folder: Folder) {
        coordinatorDelegate?.userInitiatedInfoFolder(folder: folder)
    }
    
    func handleCreatorFolderButtonAction() {
        coordinatorDelegate?.userInitiatedCreatorFolder(folder: nil, state: .insert)
    }
    
    func handleNoteButtonAction(folder: Folder) {
        coordinatorDelegate?.userInitiatedNote(folder: folder)
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
    
    func handleDeleteItem(folder: Folder) {
        self.database.deleteItem(item: folder)
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
    
    func getObject(at indexPath: IndexPath) -> Folder? {
        fetchResultController.object(at: indexPath)
    }
}
