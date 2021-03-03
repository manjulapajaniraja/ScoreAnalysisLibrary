//
//  UserStatsInfo.swift
//  StatsData
//
//  Created by Manjula Pajaniraja on 02/03/21.
//

import Foundation

struct UserStatsInfo: Decodable {
    let date: String? //updated date
    let lowRange: Int?
    let highRange: Int?
    let userRangeValue: Int?
    let rangeDetails: [RangeDetails]?
}


struct RangeDetails: Decodable {
    let low: Int?
    let high: Int?
    let percentage: Int?
}
