//
//  FavouriteImagesCoordinator.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-13.
//

import Foundation
import UIKit

//MARK: - Main Coordinator protocol
protocol FavouriteImagesCoordinatorProtocol: BaseCoordinator {}


//MARK: - Main Coordinator
final class FavouriteImagesCoordinator {
    var navigationController: UINavigationController
    
    
    //MARK: Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationController()
    }
}


//MARK: - Main Coordinator protocol extension
extension FavouriteImagesCoordinator: FavouriteImagesCoordinatorProtocol {
    
    //MARK: Internal
    internal func start() {
        let rootVC = FavouriteImagesTableViewController()
        let presenter = FavouriteImagesPresenter(view: rootVC)
        rootVC.presenter = presenter
        navigationController.viewControllers = [rootVC]
    }
}


//MARK: - Main methods
private extension FavouriteImagesCoordinator {
    
    //MARK: Private
    func setupNavigationController() {
        let tabBarItemImage = UIImage(systemName: "star")
        let tabBarItemSelectedImage = UIImage(systemName: "star.fill")
        let tabBarItem = UITabBarItem(title: "Search", image: tabBarItemImage, selectedImage: tabBarItemSelectedImage)
        navigationController.tabBarItem = tabBarItem
    }
}
