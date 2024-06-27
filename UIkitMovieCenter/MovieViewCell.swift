//
//  MovieViewCell.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 26/6/24.
//

import UIKit

class MovieViewCell: UICollectionViewCell {
    
    static var identifier = "MovieViewCell"
    
    
    @IBOutlet var movieImage: UIImageView!
    
    @IBOutlet var movieTitle: UILabel!
    
    var movie : Movie? {
        didSet{
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        movieImage.layer.cornerRadius = 8
    }
    
    
    private func configureCell(){
        guard let movie = movie else{
            print("Problem in Loading Movie")
            return
        }
        
        movieImage.image = UIImage(named: movie.image)
        movieTitle.text = movie.name
        
    }
    

}
