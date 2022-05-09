//
//  CreatorNotePresenter.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import Foundation

final class CreatorNotePresenter {
    weak var coordinatorDelegate: NoteCoordinatorDelegate?
    weak var delegate: CreatorNoteViewInterface?
    private let model: CreatorNoteModel
    private let database: Database
    private let state: State
    
    init(model: CreatorNoteModel, database: Database, state: State) {
        self.model = model
        self.database = database
        self.state = state
    }
    
    func nameDidChange(with text: String?) {
        guard state == .update else {
            model.name = text
            return
        }
        model.note?.name = text
    }
    
    func stringContentDidChange(with text: String?) {
        guard state == .update else {
            model.stringContent = text
            return
        }
        model.note?.stringContent = text
    }
    
    func handleSaveButtonAction() {
        delegate?.resignAllResponders()
        if state == .insert {
            guard let name = model.name, let stringContent = model.stringContent else { return }
            let note = self.database.createNote(name: name, stringContent: stringContent)
            model.folder.addNoteInFolder(note: note)
        } else {
            database.saveContext()
        }
        coordinatorDelegate?.popViewController()
    }
    
    func config() -> Note? {
        guard state == .update else { return nil }
        return model.note
    }
}
