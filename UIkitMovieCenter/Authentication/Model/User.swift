//
//  User.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 5/7/24.
//

import Foundation

struct User: Identifiable, Codable{
    let id : String
    let fullName : String
    let email : String
    var movieWatchList : [MovieListItemModel]?
    
    
    var initials : String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
    
}


