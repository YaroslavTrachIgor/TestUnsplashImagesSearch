//
//  UserDefault.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-11.
//

import Foundation

//MARK: - Main Property Wrapper
@propertyWrapper
struct UserDefault<T> {
    let key: String
    let defaultValue: T

    
    //MARK: Initialization
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    //MARK: WrappedValue
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
