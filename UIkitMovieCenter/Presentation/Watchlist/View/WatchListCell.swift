//
//  WatchListCell.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 8/7/24.
//

import UIKit

class WatchListCell: UITableViewCell {
    
    static var identifier = "WatchListCell"
    @IBOutlet var moviePoster: UIImageView!
    @IBOutlet var genre: UILabel!
    @IBOutlet var movieName: UILabel!
    @IBOutlet var year: UILabel!
    @IBOutlet var runtime: UILabel!
    @IBOutlet var rating: UILabel!
    
    var movie : MovieListItemModel? {
        didSet{
            configureCell()
        }
    }
    
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func getGenreString(movie : MovieListItemModel) -> String{
        
        if let genreStrings = movie.genres?.map({ $0.toString() })  {
            let combinedString = genreStrings.enumerated().map { (index, element) in
                 if index == genreStrings.count - 1 {
                           return element
                       } else {
                           return element + " • "
                       }
                   }.joined()
            return combinedString
        }
       
        return ""
        
    }
    
    func configureCell(){
        guard let movie = movie else{
            print("Problem in Loading Movie in Search Cell")
            return
        }
        
        moviePoster.setImage(with: movie.poster)
        movieName.text = movie.title
        rating.text = String(movie.rating)
        year.text = String(movie.releaseYear)
        runtime.text = Utilities.minutesToHoursAndMinutesPoster(movie.runtime)
        genre.text = getGenreString(movie: movie)
    }
    
    
    
}
