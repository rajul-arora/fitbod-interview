//
//  GroupedWorkouts.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-23.
//

import Foundation

struct GroupedWorkouts: Identifiable {
    struct Metadata: Identifiable {
        var id: String { date.formatted() }
        
        var date: Date
        var workouts: [Workout]
        var oneRepMax: Double
    }

    var id: String { name }
    var name: String
    var metadata: [Metadata]

    /**
     Get the maximum One Rep Max based on all the workouts.
     */
    var oneRepMax: Double {
        metadata.max { a, b in
            a.oneRepMax < b.oneRepMax
        }?.oneRepMax ?? 0.0
    }
}
