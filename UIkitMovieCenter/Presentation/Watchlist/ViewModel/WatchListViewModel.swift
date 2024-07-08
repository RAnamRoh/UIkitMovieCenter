//
//  WatchListViewModel.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 8/7/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


protocol WatchListDelegate : AnyObject{
    func reloadData()
}


@MainActor
class WatchListViewModel : ObservableObject {
    
    @Published var movieWatchList : [MovieListItemModel] = [] {
        didSet{
            delegate?.reloadData()
            print("Got Em")
            
        }
    }
    
    
    static let shared = WatchListViewModel()
    
    
    private let db = Firestore.firestore()
    private var userId: String?
    @Published var currentUser: User?
    
    weak var delegate : WatchListDelegate?
    
    
     init() {
        
//        if let userId = Auth.auth().currentUser?.uid {
//            self.userId = userId
//            
//            Task {
//                await fetchUser()
//            }
//            
//        }
         if let userId = Auth.auth().currentUser?.uid {
                 self.userId = userId
                 Task {
                     await fetchUser()
                 }
             }
        
    }
    
    
    
    func setUserId(_ userId: String) {
          self.userId = userId
          Task {
              await fetchUser()
          }
      }
    
    func fetchUser() async {
        
        guard let userId = userId else {return}
        
        let userRef = db.collection("users").document(userId)
        
        
        do {
            let document = try await userRef.getDocument()
            
            if document.exists {
                self.currentUser = try document.data(as: User.self)
                self.movieWatchList = self.currentUser?.movieWatchList ?? []
                print("Fetched Data From FireStore")
            } else {
                print("No User Found in FireStore")
            }
            
        }
        catch {
            print("Error Fetchinbg Users : \(error)")
        }
        
        
    }
    
    
    func addMovies(movie : MovieListItemModel) async {
        guard userId != nil else {
            print("User not Logged IN")
            return
        }
        
        if !movieWatchList.contains(where: {$0.id == movie.id}){
            movieWatchList.append(movie)
            print("Movie added to watchlist")
            await updateFirestoreUser()
        }
        else {
            print("Movie already exists in watchlist")
        }
        
    }
    
    func deleteMovie(indexPath: IndexPath) {
       // movieWatchList.remove(atOffsets: indexSet)
        movieWatchList.remove(at: indexPath.row)
        Task{
            await updateFirestoreUser()
        }
        
    }
    
    func removeMovie(movie: MovieListItemModel) async {
         guard let userId = userId else {
             print("User not logged in")
             return
         }
         movieWatchList.removeAll { $0.id == movie.id }
         print("Movie removed from watchlist")
         await updateFirestoreUser()
     }
    
    
    
    func updateFirestoreUser() async {
        guard let userId = userId , var currentUser = currentUser else {return}
        currentUser.movieWatchList = movieWatchList
        
        let userRef = db.collection("users").document(userId)
        
        do {
            try userRef.setData(from: currentUser)
            print("User updated in Firestore")
        }
        catch{
            print("Error updating user in Firestore: \(error)")
        }
        
        
    }
    
    func clearData() {
          self.movieWatchList = []
          self.currentUser = nil
          self.userId = nil
      }
    
    
    
    
    
    
}
