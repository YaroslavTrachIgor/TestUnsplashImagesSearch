//
//  SceneDelegate.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let tabBarController = UITabBarController()
        
        let firstViewController = ImagesSearchViewController()
        let firstNavigationController = UINavigationController(rootViewController: firstViewController)
        let firstTabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: nil)
        firstNavigationController.navigationBar.backgroundColor = .systemBackground
        firstNavigationController.tabBarItem = firstTabBarItem
        
        let secondViewController = FavouriteImagesTableViewController()
        let secondNavigationController = UINavigationController(rootViewController: secondViewController)
        let secondTabBarItem = UITabBarItem(title: "Favourites", image: UIImage(systemName: "star"), selectedImage: nil)
        secondNavigationController.navigationBar.backgroundColor = .systemBackground
        secondNavigationController.tabBarItem = secondTabBarItem
        
        tabBarController.setViewControllers([firstNavigationController, secondNavigationController], animated: true)
        tabBarController.tabBar.backgroundColor = .systemBackground
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

