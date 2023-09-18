//
//  FavouritesStorage.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import Foundation
import UIKit
import SwiftUI

//MARK: - Constants
private enum Constants {
    enum UserDefaultKeys {
        
        //MARK: Static
        static let favouriteImagesData = "FavouriteImagesDataKey"
    }
}


//MARK: - Storage Injector protocol
protocol FavouritesStorageInjector {
    var favouritesStorage: FavouritesStorage { get }
}


//MARK: - Storage Injector protocol extension
extension FavouritesStorageInjector {
    var favouritesStorage: FavouritesStorage {
        FavouritesStorage.shared
    }
}


//MARK: - Storage Observer protocol
protocol FavouritesStorageObserver: AnyObject {
    func favouritesStorageDidUpdate()
}


//MARK: - Main Storage
final class FavouritesStorage {
    
    //MARK: Private
    @UserDefault(Constants.UserDefaultKeys.favouriteImagesData, defaultValue: nil)
    private var favouriteImagesData: Data?
    private var observers = [FavouritesStorageObserver]()
    
    //MARK: Static
    static let shared = FavouritesStorage()
    
    
    //MARK: Initialization
    private init() {}
    
    //MARK: Public
    func fetch() -> [FavouriteImage] {
        decodeImages()
    }
    
    func remove(at row: Int) {
        var favouriteImages = decodeImages()
        favouriteImages.remove(at: row)
        encodeImages(favouriteImages)
        notifyObservers()
    }
    
    func insert(_ image: FavouriteImage) {
        var favouriteImages = decodeImages()
        favouriteImages.insert(image, at: 0)
        encodeImages(favouriteImages)
        notifyObservers()
    }
    
    func addObserver(_ observer: FavouritesStorageObserver) {
        observers.append(observer)
    }
}


//MARK: - Main methods
private extension FavouritesStorage {
    
    //MARK: Private
    func decodeImages() -> [FavouriteImage] {
        guard let data = favouriteImagesData else { return [] }
        let favouriteImages: [FavouriteImage]? = JSONHelper.decode(data)
        return favouriteImages ?? []
    }
    
    func encodeImages(_ favouriteImages: [FavouriteImage]) {
        favouriteImagesData = JSONHelper.encode(favouriteImages)
    }
    
    func notifyObservers() {
        observers.forEach { $0.favouritesStorageDidUpdate() }
    }
}
