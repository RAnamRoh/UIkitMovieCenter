//
//  WatchlistVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import UIKit

class WatchlistVC: UIViewController {
    
    
    let viewModel = WatchListViewModel.shared
    
   // var movies = ["A","B","C","D","A","B","C","D","A","B","C","D","A","B","C","D","A","B","C","D"]
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let nibName = UINib(nibName: WatchListCell.identifier, bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: WatchListCell.identifier)
//        let nibName = UINib(nibName: SearchCell.identifier, bundle: nil)
//        tableView.register(nibName, forCellReuseIdentifier: SearchCell.identifier)
        
        
        viewModel.delegate = self
       
    }
    

   

}

extension WatchlistVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieWatchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WatchListCell.identifier, for: indexPath) as! WatchListCell
       // cell.textLabel?.text = viewModel.movieWatchList[indexPath.row].title
        cell.movie = viewModel.movieWatchList[indexPath.row]
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            
            //viewModel.deleteMovie(indexSet: indexPath.row)
            viewModel.deleteMovie(indexPath: indexPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        destinationVC.movieId = viewModel.movieWatchList[indexPath.row].id
        self.navigationController?.pushViewController(destinationVC, animated: true)
    }
    
}

extension WatchlistVC : WatchListDelegate {
    func reloadData() {
        tableView.reloadData()
    }
    
    
}
