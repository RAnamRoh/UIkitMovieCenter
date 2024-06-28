//
//  UIImageView + Extention.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 28/6/24.
//



import Kingfisher
import UIKit

extension UIImageView {
    
    func setImage(with urlString : String){
        guard let url = URL.init(string: urlString) else {
            return
        }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resource)
    }
    
}
