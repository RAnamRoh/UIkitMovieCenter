//
//  Utilities.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 2/7/24.
//

import Foundation



class Utilities {

    static func minutesToHoursAndMinutes(_ minutes: Int) -> String {
      let hours = minutes / 60
      let minutesRemaining = minutes % 60

      if minutesRemaining == 0 {
        return "\(hours) hour"
      } else {
        return "\(hours) hour \(minutesRemaining) mins"
      }
    }
    
    static func minutesToHoursAndMinutesPoster(_ minutes: Int) -> String {
      let hours = minutes / 60
      let minutesRemaining = minutes % 60

      if minutesRemaining == 0 {
        return "\(hours) h"
      } else {
        return "\(hours)h \(minutesRemaining)m"
      }
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
}
