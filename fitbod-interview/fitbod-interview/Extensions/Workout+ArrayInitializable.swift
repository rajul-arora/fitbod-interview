//
//  Workout+ArrayInitializable.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import Foundation

extension Workout: ArrayInitializable {
    init(_ array: [Any]) throws {
        guard array.count == 5 else {
            throw ArrayInitializationError.invalidArrayLength
        }

        let formatter: DateFormatter = .workoutDateFormat

        guard
            let dateString = array[0] as? String,
            let date = formatter.date(from: dateString)
        else {
            throw ArrayInitializationError.invalidFormat("\(array[0]) is not a valid date")
        }

        guard let name = array[1] as? String else {
            throw ArrayInitializationError.invalidFormat("\(array[1]) is not a valid string")
        }

        guard let setsString = array[2] as? String, let sets = Int64(setsString) else {
            throw ArrayInitializationError.invalidFormat("\(array[2]) is not a valid integer")
        }

        guard let repsString = array[3] as? String, let reps = Int64(repsString) else {
            throw ArrayInitializationError.invalidFormat("\(array[3]) is not a valid integer")
        }

        guard let weightString = array[4] as? String, let weight = Double(weightString) else {
            throw ArrayInitializationError.invalidFormat("\(array[4]) is not a valid double")
        }

        self.date = date
        self.name = name
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}
