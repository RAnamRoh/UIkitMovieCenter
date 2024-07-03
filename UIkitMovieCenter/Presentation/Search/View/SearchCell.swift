//
//  SearchCell.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import UIKit

class SearchCell: UITableViewCell {
    
    
    static var identifier = "SearchCell"
    
    @IBOutlet var myView: UIView!
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var rating: UILabel!
    
    @IBOutlet var year: UILabel!
    
    @IBOutlet var runtime: UILabel!
    
    
    @IBOutlet var genre: UILabel!
    
    @IBOutlet var watchListBTN: UIButton!
    
    var movie : MovieListItemModel? {
        didSet{
            configureCell()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    
        
        //posterImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(){
        
        guard let movie = movie else{
            print("Problem in Loading Movie in Search Cell")
            return
        }
        
        posterImage.setImage(with: movie.poster)
        movieName.text = movie.title
        rating.text = String(movie.rating)
        year.text = String(movie.releaseYear)
        runtime.text = Utilities.minutesToHoursAndMinutesPoster(movie.runtime)
        genre.text = getGenreString(movie: movie)
    }
    
    
    func getGenreString(movie : MovieListItemModel) -> String{
        
        let genreStrings = movie.genres.map { $0.toString() }
        
        let combinedString = genreStrings.enumerated().map { (index, element) in
            if index == genreStrings.count - 1 {
                      return element
                  } else {
                      return element + " • "
                  }
              }.joined()
        
        return combinedString
    }
    
    
    
    @IBAction func watchLIstButtonPressed(_ sender: UIButton) {
        addMovieToWatchList()
    }
    
    
    private func addMovieToWatchList(){
        guard let movie = movie else {return}
        print("You Pressed a Watchlist Button for : \(movie.title)")
    }
    
}
