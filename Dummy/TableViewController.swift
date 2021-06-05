//
//  ViewController.swift
//  Dummy
//
//  Created by DonorRaja on 5/06/21.
//

import UIKit
import Alamofire
import SwiftyJSON

class TableViewController: UITableViewController {

    var albums = [AlbumModel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    var filterSearch:[AlbumModel] = []
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Here..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        loadList()
    }

    
    
    func loadList(){
        
        let url = "https://jsonplaceholder.typicode.com/todos"
        AF.request(url).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)

                for value in json.arrayValue {
                    let completed = value.dictionaryValue["completed"]!.stringValue
                    let userId = value.dictionaryValue["userId"]!.stringValue
                    let id = value.dictionaryValue["id"]!.stringValue
                    let title = value.dictionaryValue["title"]!.stringValue

                    // Add this album to array.
                    let album = AlbumModel(id: id, userId: userId, title: title, completed: completed)
                    self.albums.append(album)
                }
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }

        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterSearch.count
        }
        return self.albums.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! ListTableViewCell
        let album: AlbumModel
        if isFiltering {
            album = filterSearch[indexPath.row]
        }else {
            album = albums[indexPath.row]
        }
        cell.idLabel.text = "ID : \(String(describing: album.id!))"
        cell.completionLabel.text = "completion : \(String(describing: album.completed!))"
        cell.titleLabel.text = "Title : \(String(describing: album.title!))"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "sendDataSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sendDataSegue" {
            let indexPath = sender as! IndexPath
            let vc = segue.destination as! DetailsViewController
            let albumDetail = self.albums[indexPath.row]
            vc.userID = albumDetail.id
            vc.detailText = albumDetail.title
            vc.completedText = albumDetail.completed
        }
    }
}

extension TableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filterSearch = albums.filter { (album: AlbumModel) -> Bool in
        return album.title!.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }
}

extension TableViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar,
      selectedScopeButtonIndexDidChange selectedScope: Int) {
      filterContentForSearchText(searchBar.text!)
  }
}
