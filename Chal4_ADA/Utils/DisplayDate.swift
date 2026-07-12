//
//  DisplayDate.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import Foundation

func displayString(for date: Date) -> String {
    let calendar = Calendar.current
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "hh.mm a"

    if calendar.isDateInToday(date) {
        return timeFormatter.string(from: date) // Contoh: "01.00 AM"
    } else if calendar.isDateInYesterday(date) {
        return "Yesterday"
    } else {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: date) // Contoh: "Jul 10"
    }
}
