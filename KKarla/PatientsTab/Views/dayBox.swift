//
//  dayBox.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit


class dayBox: UIView {
    
}

enum calendarSquare {
    case noDay
    case regulardDay
    
    var borderColor: CGColor {
        switch self{
        case .noDay:
            return UIColor.white.cgColor
        case .regulardDay:
            return UIColor.darkGray.cgColor
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .noDay:
            return .lightGray
        case .regulardDay:
            return .black
        }
    }
}

struct Week {
    var sevenDays: [calendarSquare]?
    var weekNumber: Int
    var yearNumber: Int
    var monthNumber: Int?
    
    init(monthNumber: Int, yearNumber: Int, weekNumber:Int){
        self.yearNumber = yearNumber
        self.weekNumber = weekNumber
        self.monthNumber = monthNumber
    }
    
    init(yearNumber:Int, weekNumber: Int){
        self.yearNumber = yearNumber
        self.weekNumber = weekNumber
    }
}

struct Month {
    var fiveWeeks: [Week]
    var monthNumber: Int
    var yearNumber: Int
}
