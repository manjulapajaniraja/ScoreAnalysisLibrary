//
//  UserStatsBindable.swift
//  StatsData
//
//  Created by Manjula Pajaniraja on 03/03/21.
//

import Foundation

class UserStatsBindable<T> {
    var value: T? {
        didSet {
            observer?(self.value)
        }
    }
    
    var observer: ((T?) -> ())?
    
    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}

