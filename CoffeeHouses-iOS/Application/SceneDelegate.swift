//
//  SceneDelegate.swift
//  CoffeeHouses-iOS
//
//  Created by Andrey Ulanov on 22.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    class MockAuthTokenStorage: AuthTokenStorage {
        var token: String? = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJBdXRoZW50aWNhdGlvbiIsImlzcyI6ImNvZmZlZSBiYWNrZW5kIiwiaWQiOjk1LCJleHAiOjE3MDM0OTc0Mjl9.FAcy-k3TDDqA4FjRhxeqL-VijiJv0lQ8RlA9xc40A8A"
        
        func setToken(_ token: String) {
            return
        }
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let navController = UINavigationController()
        let cafesMapModule = CafesMapModuleBuilder.build(cafes: [
            CoffeeLocation(id: 1, name: "Арома", point: MapPoint(latitude: "44.43000000000000", longitude: "44.43000000000000")),
            CoffeeLocation(id: 2, name: "Кофе есть", point: MapPoint(latitude: "44.72452500000000", longitude: "44.72452500000000")),
            CoffeeLocation(id: 3, name: "ЧайКофф", point: MapPoint(latitude: "44.83000000000000", longitude: "44.83000000000000")),
        ])
        navController.pushViewController(cafesMapModule, animated: false)
//        if let token = MockAuthTokenStorage().token {
//            let module = CafesListModuleBuilder.build(authToken: token)
//            navController.pushViewController(module, animated: false)
//        } else {
//            let module = SignInModuleBuilder.build()
//            navController.pushViewController(module, animated: false)
//        }
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

