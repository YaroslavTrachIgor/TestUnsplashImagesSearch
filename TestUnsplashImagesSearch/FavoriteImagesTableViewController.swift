//
//  FavoriteImagesTableViewController.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import UIKit

class FavoriteImagesTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGroupedBackground
        
        let cellIdentifier = String(describing: FavouriteImageCollectionViewCell.self)
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    //MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: FavouriteImageCollectionViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FavouriteImageCollectionViewCell

        return cell
    }
}
