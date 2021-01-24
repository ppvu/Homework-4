//
//  Global.swift
//  WeatherApp
//
//  Created by spezza on 19.01.2021.
//

import Foundation
import UIKit

extension Date {
    
    static func getDateFrom(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        return dateFormatter.string(from: date)
    }
}
