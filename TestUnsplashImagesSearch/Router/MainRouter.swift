//
//  MainRouter.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-13.
//

import Foundation
import UIKit

//MARK: - Base Router protocol
protocol Router {
    var tabBarController: UITabBarController { get set }
    func start()
}


//MARK: - Main Coordinator protocol
protocol MainRouterProtocol: Router {}


//MARK: - Main Coordinator
final class MainRouter: MainRouterProtocol {
    var tabBarController: UITabBarController
    
    //MARK: Private
    var favouriteImagesFlowRouter: FavouriteImagesCoordinatorProtocol?
    var searchImagesFlowRouter: ImagesSearchCoordinatorProtocol?
    
    
    //MARK: Initialization
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        
        setupTabBar()
        setupImagesSearchCoordinator()
        setupFavouriteImagesCoordinator()
    }
}


//MARK: - Main Coordinator protocol extension
extension MainRouter {
    
    //MARK: Internal
    internal func start() {
        let imagesSearchNavigationController = searchImagesFlowRouter?.navigationController
        let favouriteImagesNavigationController = favouriteImagesFlowRouter?.navigationController
        let viewControllers = [imagesSearchNavigationController!, favouriteImagesNavigationController!]
        tabBarController.viewControllers = viewControllers
    }
}


//MARK: - Main methods
private extension MainRouter {
    
    //MARK: Private
    func setupFavouriteImagesCoordinator() {
        let navigationController = UINavigationController()
        let coordinator = FavouriteImagesCoordinator(navigationController: navigationController)
        favouriteImagesFlowRouter = coordinator
        favouriteImagesFlowRouter?.start()
    }
    
    func setupImagesSearchCoordinator() {
        let navigationController = UINavigationController()
        let coordinator = ImagesSearchCoordinator(navigationController: navigationController)
        searchImagesFlowRouter = coordinator
        searchImagesFlowRouter?.start()
    }
    
    func setupTabBar() {
        tabBarController.tabBar.backgroundColor = .systemBackground
        tabBarController.tabBar.tintColor = .systemPink
    }
}
