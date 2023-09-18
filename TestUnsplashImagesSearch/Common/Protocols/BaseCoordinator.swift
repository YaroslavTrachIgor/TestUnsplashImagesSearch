//
//  BaseCoordinator.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-13.
//

import Foundation
import UIKit

//MARK: - Base Coordinator protocol
protocol BaseCoordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
