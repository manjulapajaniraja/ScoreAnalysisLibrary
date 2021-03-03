//
//  UserStatsViewModel.swift
//  StatsData
//
//  Created by Manjula Pajaniraja on 02/03/21.
//

import Foundation

class UserStatsViewModel {
    
    var userStatsData = UserStatsBindable<UserStatsInfo>() //Model to load the view
    
    
    func createModel(fromData data: Data) {
        userStatsData.value = try? JSONDecoder.init().decode(UserStatsInfo.self, from: data)
    }
    
    //This method will check and update if the given range is the user's.
    
    func isUserRange(rangeDetails: RangeDetails) -> Bool {
        
        guard let userRange = userStatsData.value?.userRangeValue, let low = rangeDetails.low , let high = rangeDetails.high else {
            return false
        }
        if low < userRange && userRange < high { return true }
        return false
    }
    
    
    
}
