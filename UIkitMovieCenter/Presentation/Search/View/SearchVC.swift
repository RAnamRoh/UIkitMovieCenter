//
//  SearchVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import UIKit

class SearchVC: UIViewController {
    
    
    @IBOutlet var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    let viewModel = SearchViewModel(movieRepository: MovieRepositoryImpl(apiService: ApiServiceImpl(apiClient: ApiClientImpl())))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: SearchCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: SearchCell.identifier)
        
        initViewModel()
    }
    
    func initViewModel(){
        viewModel.userDelegate = self
    }


}


extension SearchVC : UserServices {
    func reloadData() {
        self.tableView.reloadData()
    }
 
}

extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = viewModel.movieList[indexPath.row].title
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        cell.movie = viewModel.movieList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
//        destinationVC.movieId = viewModel.movieList[indexPath.row].id
//        print(viewModel.movieList[indexPath.row].id)
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        destinationVC.movieId = viewModel.movieList[indexPath.row].id
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension SearchVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchQuery = searchText
    }
}



