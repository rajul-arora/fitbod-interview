//
//  DateFormatter+Additions.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import Foundation

extension DateFormatter {
    static var workoutDateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current
        return formatter
    }
}
