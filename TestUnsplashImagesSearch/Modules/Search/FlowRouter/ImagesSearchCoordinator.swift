//
//  ImagesSearchCoordinator.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-13.
//

import Foundation
import UIKit

//MARK: - Main Coordinator protocol
protocol ImagesSearchCoordinatorProtocol: BaseCoordinator {}


//MARK: - Main Coordinator
final class ImagesSearchCoordinator {
    var navigationController: UINavigationController
    
    
    //MARK: Initialization
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        setupNavigationController()
    }
}


//MARK: - Main Coordinator protocol extension
extension ImagesSearchCoordinator: ImagesSearchCoordinatorProtocol {
    
    //MARK: Internal
    internal func start() {
        let rootVC = ImagesSearchViewController()
        let presenter = ImagesSearchPresenter(view: rootVC)
        rootVC.presenter = presenter
        navigationController.viewControllers = [rootVC]
    }
}


//MARK: - Main methods
private extension ImagesSearchCoordinator {
    
    //MARK: Private
    func setupNavigationController() {
        let tabBarItemImage = UIImage(systemName: "magnifyingglass")
        let tabBarItemSelectedImage = UIImage(systemName: "magnifyingglass")
        let tabBarItem = UITabBarItem(title: "Search", image: tabBarItemImage, selectedImage: tabBarItemSelectedImage)
        navigationController.tabBarItem = tabBarItem
    }
}
