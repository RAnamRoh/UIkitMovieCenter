//
//  HomeVC.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 25/6/24.
//

import UIKit

class HomeVC: UIViewController {
    
    
    @IBOutlet var movieCollectionView: UICollectionView!
    
    
    @IBOutlet var topPicksCollectionView: UICollectionView!
    
    
    private let viewModel = MovieListViewModel(
        movieRepository: MovieRepositoryImpl(apiService: ApiServiceImpl(apiClient: ApiClientImpl())))
    
    var movies : [Movie] = [
    Movie(name: "Movie 1", image: "tempBack"),
    Movie(name: "Movie 2", image: "tempBack"),
    Movie(name: "Movie 3", image: "tempBack"),
    Movie(name: "Movie 4", image: "tempBack"),
    Movie(name: "Movie 5", image: "tempBack")
    
    ]
    
    func initViewModel(){
        viewModel.userDelegate = self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        initViewModel()
        
        let nibName = UINib(nibName: MovieViewCell.identifier, bundle: nil)
        self.movieCollectionView.register(nibName, forCellWithReuseIdentifier: MovieViewCell.identifier)
        self.movieCollectionView.showsHorizontalScrollIndicator = false
        
        self.topPicksCollectionView.register(nibName, forCellWithReuseIdentifier: MovieViewCell.identifier)
        self.topPicksCollectionView.showsHorizontalScrollIndicator = false
  
    }
    

}

extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as! MovieViewCell
        cell.movie = viewModel.movieList[indexPath.row]
        return cell
    }
    
    
}

extension HomeVC : UserServices{
    func reloadData() {
        self.movieCollectionView.reloadData()
        self.topPicksCollectionView.reloadData()
    }
    
    
}

