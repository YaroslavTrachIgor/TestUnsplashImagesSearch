//
//  FavouriteImagesTableViewController.swift
//  TestUnsplashImagesSearch
//
//  Created by User on 2023-09-08.
//

import UIKit

class FavouriteImagesTableViewController: UITableViewController, FavouritesStorageInjector {
    
    private var rows = [FavouriteImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favourites"
        
        let cellIdentifier = String(describing: FavouriteImageTableViewCell.self)
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 115
        
        favouritesStorage.addObserver(self)
        rows = favouritesStorage.fetch()
    }
    
    //MARK: TableView DataSource protocol
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: FavouriteImageTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavouriteImageTableViewCell
        let row = rows[indexPath.row]
        cell.previewImageView.downloadImage(with: URL(string: row.stringURL))
        cell.titleLabel.text = row.name
        cell.subtitleLabel.text = row.username
        cell.bottomLabel.text = row.dateString
        return cell
    }
}


extension FavouriteImagesTableViewController: FavouritesStorageObserver {
    func favouritesStorageDidUpdate() {
        tableView.reloadData()
    }
}
