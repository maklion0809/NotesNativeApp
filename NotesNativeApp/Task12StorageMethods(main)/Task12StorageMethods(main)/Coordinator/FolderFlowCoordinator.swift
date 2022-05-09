//
//  FolderFlowCoordinator.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.11.2021.
//

import UIKit

protocol FolderCoordinatorDelegate: AnyObject {
    func userInitiatedInfoFolder(folder: Folder)
    func userInitiatedCreatorFolder(folder: Folder?, state: State)
    func userInitiatedNote(folder: Folder)
    func popToRootViewController()
}

final class FolderFlowCoordinator: Coordinator {
    private var noteFlowCoordinator: NoteFlowCoordinator?
    private let navigationController: UINavigationController
    private let dataBase: Database
    
    init(navigationController: UINavigationController, dataBase: Database) {
        self.navigationController = navigationController
        self.dataBase = dataBase
    }
    
    func start() {
        let controller = FolderViewController()
        let presenter = FolderPresenter(model: FolderModel(), database: dataBase)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
    }
}

extension FolderFlowCoordinator: FolderCoordinatorDelegate {
    func popToRootViewController() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func userInitiatedInfoFolder(folder: Folder) {
        let controller = InfoFolderViewController()
        let presenter = InfoFolderPresenter(model: InfoFolderModel(folder: folder), database: dataBase)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
    }
    
    func userInitiatedCreatorFolder(folder: Folder?, state: State) {
        let controller = CreatorFolderViewController()
        let model = CreatorFolderModel()
        model.folder = folder
        let presenter = CreatorFolderPresenter(model: model, dataBase: dataBase, state: state)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
    }
    
    func userInitiatedNote(folder: Folder) {
        noteFlowCoordinator = NoteFlowCoordinator(navigationController: navigationController, dataBase: dataBase, folder: folder)
        noteFlowCoordinator?.start()
    }
}
