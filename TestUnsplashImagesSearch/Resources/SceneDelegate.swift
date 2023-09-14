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
        let mainRouter = MainRouter(tabBarController: tabBarController)
        mainRouter.start()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}



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
    var favouriteImagesRouter: FavouriteImagesCoordinatorProtocol?
    var searchImagesRouter: ImagesSearchCoordinatorProtocol?
    
    
    //MARK: Initialization
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        setupTabBar()
    }
}


//MARK: - Main Coordinator protocol extension
extension MainRouter {
    
    //MARK: Internal
    internal func start() {
        let favouriteImagesNavigationController = UINavigationController()
        favouriteImagesRouter = FavouriteImagesCoordinator(navigationController: favouriteImagesNavigationController)
        favouriteImagesRouter?.start()
        
        let imagesSearchNavigationController = UINavigationController()
        searchImagesRouter = ImagesSearchCoordinator(navigationController: imagesSearchNavigationController)
        searchImagesRouter?.start()
        
        tabBarController.viewControllers = [imagesSearchNavigationController, favouriteImagesNavigationController]
    }
}


//MARK: - Main methods
private extension MainRouter {
    
    //MARK: Private
    func setupTabBar() {
        tabBarController.tabBar.backgroundColor = .systemBackground
    }
}










//MARK: - Base Coordinator protocol
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}






//MARK: - Main Coordinator protocol
protocol ImagesSearchCoordinatorProtocol: Coordinator {}


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
        navigationController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
    }
}





//MARK: - Main Coordinator protocol
protocol FavouriteImagesCoordinatorProtocol: Coordinator {}


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
        navigationController.tabBarItem = UITabBarItem(title: "Favoutites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
    }
}
