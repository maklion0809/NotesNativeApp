//
//  SceneDelegate.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 27.10.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var dataBase = Database()
    private var applicationFlowCoordinator: ApplicationFlowCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        applicationFlowCoordinator = ApplicationFlowCoordinator.init(window: window, dataBase: dataBase)
                applicationFlowCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        dataBase.saveContext()
    }
}

