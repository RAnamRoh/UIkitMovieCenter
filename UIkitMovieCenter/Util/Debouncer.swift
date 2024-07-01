//
//  Debouncer.swift
//  UIkitMovieCenter
//
//  Created by BS00834 on 1/7/24.
//

import Foundation

class Debouncer{
    static let shared = Debouncer(delay: 0.5)
    
    private var timer: Timer?
    
    private var delay: TimeInterval
    
    init(delay: TimeInterval) {
        self.delay = delay
    }
    
    func debounce(action: @escaping () -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
            action()
        }
    }
}
