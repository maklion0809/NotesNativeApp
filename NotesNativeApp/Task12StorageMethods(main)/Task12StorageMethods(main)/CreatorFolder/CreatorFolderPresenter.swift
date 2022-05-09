//
//  CreatorFolderPresenter.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import UIKit

final class CreatorFolderPresenter {
    
    weak var coordinatorDelegate: FolderCoordinatorDelegate?
    weak var delegate: CreatorFolderViewInterface?
    private let model: CreatorFolderModel
    private let database: Database
    private let state: State
    
    init(model: CreatorFolderModel, dataBase: Database, state: State) {
        self.model = model
        self.database = dataBase
        self.state = state
    }
    
    func nameDidChange(with text: String?) {
        guard state == .update else {
            model.name = text
            return
        }
        model.folder?.name = text
    }
    
    func folderDescriptionDidChange(with text: String?) {
        guard state == .update else {
            model.folderDescription = text
            return
        }
        model.folder?.folderDescription = text
    }
    
    func handleSaveButtonAction() {
        delegate?.resignAllResponders()
        if state == .insert {
            guard let name = model.name, let folderDescription = model.folderDescription else { return }
            database.createFolder(name: name, folderDescription: folderDescription)
        } else {
            let modificaton = self.database.createModification()
            model.folder?.addModificationsInFolder(modification: modificaton)
            database.saveContext()
        }
        coordinatorDelegate?.popToRootViewController()
    }
    
    func config() -> Folder? {
        guard state == .update else { return nil }
        return model.folder
    }
}
