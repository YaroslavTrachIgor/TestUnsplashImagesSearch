//
//  ImagesSearchPresenter.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import Foundation

protocol ImagesSearchPresenterProtocol {
    func onViewDidLoad(completion: @escaping (([ImageAPIResult]) -> ()))
    func onSearchButtonClicked(searchText: String, completion: @escaping (([ImageAPIResult]) -> ()))
    func onDidSelectItem(row: ImageAPIResult)
}


final class ImagesSearchPresenter: ImagesSearchPresenterProtocol, FavouritesStorageInjector {
    
    private var apiClient: ImagesSearchAPIClientProtocol?
    private var images = [ImageAPIResult]()
    private weak var view: ImagesSearchViewControllerProtocol!
    
    init(view: ImagesSearchViewControllerProtocol?) {
        self.view = view
    }
    
    //MARK: Presenter protocol
    func onViewDidLoad(completion: @escaping (([ImageAPIResult]) -> ())) {
        view?.setupMainUI()
        getImageResults(forQuery: "office", completion: { images in
            self.images = images
            completion(images)
            self.view?.reloadCollectionView()
        })
    }
    
    func onSearchButtonClicked(searchText: String, completion: @escaping (([ImageAPIResult]) -> ())) {
        getImageResults(forQuery: searchText, completion: { images in
            self.images = images
            self.view?.clearRows()
            completion(images)
            self.view?.reloadCollectionView()
        })
    }
    
    func onDidSelectItem(row: ImageAPIResult) {
        let favouriteImage = FavouriteImage(name: row.user.name,
                                            username: row.user.username,
                                            stringURL: row.urls.regular,
                                            dateString: row.created_at)
        favouritesStorage.insert(favouriteImage)
        view?.presentAddToFavoutitesAlertController()
    }
}


//MARK: - Main methods
private extension ImagesSearchPresenter {
    func getImageResults(forQuery query: String, completion: @escaping (([ImageAPIResult]) -> ())) {
        Task {
            let urlString = "https://api.unsplash.com/search/photos?page=1&query=\(query)&client_id=8j6210mImZuUG3VqxuDR5MfdNuHUl5dGLtQkgDfjpmY"
            if let url = URL(string: urlString) {
                do {
                    apiClient = ImagesSearchAPIClient(url: url)
                    let response = try await apiClient!.getImages()
                    let imagesResults = response?.results ?? []
                    DispatchQueue.main.async {
                        completion(imagesResults)
                    }
                } catch let error as APIError.ACRequestError {
                    print("API Error: \(error.localizedDescription)")
                } catch {
                    print("Unknown Error")
                }
            }
        }
    }
}
