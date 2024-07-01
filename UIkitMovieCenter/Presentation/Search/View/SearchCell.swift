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
    
    
    var movie : MovieListItemModel? {
        didSet{
            configureCell()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        myView.layer.cornerRadius = 20
        myView.clipsToBounds = true
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
    }
    
}
