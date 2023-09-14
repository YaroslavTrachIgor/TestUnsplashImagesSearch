//
//  FavouritesStorage.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import Foundation
import UIKit
import SwiftUI

protocol FavouritesStorageInjector {
    var favouritesStorage: FavouritesStorage { get }
}

extension FavouritesStorageInjector {
    var favouritesStorage: FavouritesStorage {
        return sharedFavouritesStorage
    }
}

fileprivate var sharedFavouritesStorage = FavouritesStorage.shared


protocol FavouritesStorageObserver: AnyObject {
    func favouritesStorageDidUpdate()
}

final class FavouritesStorage {
    
    @UserDefault("FavouriteImagesDataKey", defaultValue: nil)
    private var favouriteImagesData: Data?
    private var observers = [FavouritesStorageObserver]()
    
    static let shared = FavouritesStorage()
    
    private init() {}
    
    func fetch() -> [FavouriteImage] {
        return decodeImages()
    }
    
    func remove(at row: Int) {
        var favouriteImages = decodeImages()
        favouriteImages.remove(at: row)
        favouriteImagesData = encodeImages(favouriteImages)
        notifyObservers()
    }
    
    func insert(_ image: FavouriteImage) {
        var favouriteImages = decodeImages()
        favouriteImages.insert(image, at: 0)
        favouriteImagesData = encodeImages(favouriteImages)
        notifyObservers()
    }
    
    func addObserver(_ observer: FavouritesStorageObserver) {
        observers.append(observer)
    }
}

private extension FavouritesStorage {
    func decodeImages() -> [FavouriteImage] {
        guard let data = favouriteImagesData else { return [] }
        let favouriteImages: [FavouriteImage]? = JSONHelper.decode(data)
        return favouriteImages ?? []
    }
    
    func encodeImages(_ favouriteImages: [FavouriteImage]) -> Data? {
        let favouriteImages: Data? = JSONHelper.encode(favouriteImages)
        return favouriteImages
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.favouritesStorageDidUpdate()
        }
    }
}
