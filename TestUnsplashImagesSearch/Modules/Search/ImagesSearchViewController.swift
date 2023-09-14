//
//  ImagesSearchCollectionViewController.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import UIKit

protocol ImagesSearchViewControllerProtocol: AnyObject {
    func setupMainUI()
    func reloadCollectionView()
    func presentAddToFavoutitesAlertController()
    func clearRows()
}

final class ImagesSearchViewController: UIViewController, ImagesSearchViewControllerProtocol, FavouritesStorageInjector {
    
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    private var rows = [ImageAPIResult]()
    
    var presenter: ImagesSearchPresenterProtocol?
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad { rows in
            self.rows = rows
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchBar.frame = CGRect(x: 10, y: view.safeAreaInsets.top, width: view.frame.size.width - 20, height: 50)
        collectionView.frame = CGRect(x: 0, y: view.safeAreaInsets.top + 50, width: view.frame.size.width, height: view.frame.size.height - 50)
    }
    
    //MARK: ViewController protocol
    func clearRows() {
        rows = []
    }
    
    func setupMainUI() {
        configureUI()
        configureCollectionView()
    }
    
    func reloadCollectionView() {
        collectionView.reloadData()
    }
    
    func presentAddToFavoutitesAlertController() {
        let title = "Added to Favourites"
        let message = "The Image was added to Favourites section."
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let continueAction = UIAlertAction(title: "Continue", style: .cancel)
        alertVC.addAction(continueAction)
        present(alertVC, animated: true)
    }
    
    //MARK: UI Configuration
    private func configureUI() {
        title = "Search"
        
        searchBar.delegate = self
        view.addSubview(searchBar)
        view.backgroundColor = .systemGroupedBackground
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width / 2, height: view.frame.size.width / 2)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGroupedBackground
        view.addSubview(collectionView)
    }
}

//MARK: - SearchBar Delegate protocol extension
extension ImagesSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            presenter?.onSearchButtonClicked(searchText: searchText, completion: { rows in
                self.rows = rows
            })
        }
    }
}

//MARK: - CollectionView DataSource protocol extension
extension ImagesSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let stringURL = rows[indexPath.row].urls.regular
        if  let url = URL(string: stringURL!) {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCollectionViewCell.cellIdentifier,
                for: indexPath
            ) as! ImageCollectionViewCell
            cell.configure(with: url)
            cell.backgroundColor = .secondarySystemGroupedBackground
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.onDidSelectItem(row: rows[indexPath.row])
    }
}
