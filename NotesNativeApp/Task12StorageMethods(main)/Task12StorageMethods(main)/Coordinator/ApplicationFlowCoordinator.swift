//
//  ApplicationFlowCoordinator.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.11.2021.
//

import UIKit

final class ApplicationFlowCoordinator: Coordinator {
    private let window: UIWindow
    private let dataBase: Database
    private var folderFlowCoordinator: FolderFlowCoordinator?

    init(window: UIWindow, dataBase: Database) {
        self.window = window
        self.dataBase = dataBase
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        folderFlowCoordinator = FolderFlowCoordinator(navigationController: navigationController, dataBase: dataBase)
        folderFlowCoordinator?.start()
    }
}
