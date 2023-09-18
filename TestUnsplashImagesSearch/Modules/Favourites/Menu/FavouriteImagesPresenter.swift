//
//  FavouriteImagesPresenter.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-11.
//

import Foundation

protocol FavouriteImagesPresenterProtocol {
    func onViewDidLoad()
}


final class FavouriteImagesPresenter: FavouriteImagesPresenterProtocol {
    
    weak var view: FavouriteImagesTableViewControllerProtocol!
    
    //MARK: Initialization
    init(view: FavouriteImagesTableViewControllerProtocol!) {
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad() {
        view.setupMainUI()
        view.setupNewRows(favouritesStorage.fetch())
        favouritesStorage.addObserver(self)
        view.reloadTableView()
    }
}


extension FavouriteImagesPresenter: FavouritesStorageObserver, FavouritesStorageInjector {
    func favouritesStorageDidUpdate() {
        view.setupNewRows(favouritesStorage.fetch())
        view.reloadTableView()
    }
}
