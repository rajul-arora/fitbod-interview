//
//  WorkoutChartView.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-22.
//

import SwiftUI
import Charts

struct WorkoutChartView: View {

    @State var data: [GroupedWorkouts.Metadata]
    private let series: String = "One Rep Max"

    var body: some View {
        Chart(data) {
            LineMark(
                x: .value("Day", $0.date),
                y: .value("One Rep Max", $0.oneRepMax)
            )
            .foregroundStyle(by: .value(series, series))
            .symbol(by: .value(series, series))
        }
        .chartLegend(.hidden)
        .chartForegroundStyleScale([
            series: Color.primary
        ])
    }
}

struct WorkoutChartView_Previews: PreviewProvider {

    // Taken from WorkoutsCSVService to simplify preview testing

    fileprivate static func groupWorkouts(
        _ workouts: [Workout]
    ) -> [GroupedWorkouts] {
        let workoutsGroupedByName = Dictionary(grouping: workouts) { $0.name }
        return workoutsGroupedByName.map { key, value in
            generatedGroupedWorkout(name: key, workouts: value)
        }
    }

    fileprivate static func generatedGroupedWorkout(
        name: String,
        workouts: [Workout]
    ) -> GroupedWorkouts {
        let groupedByDate = Dictionary(grouping: workouts) { $0.date }
        let metadata = groupedByDate.map { key, value in
            GroupedWorkouts.Metadata(
                date: key,
                workouts: value.sorted { a, b in a.date < b.date },
                oneRepMax: value.map { oneRepMax(workout: $0) }.max() ?? 0.0
            )
        }.sorted { a, b in
            a.date < b.date
        }

        return GroupedWorkouts(
            name: name,
            metadata: metadata
        )
    }

    /**
     Calculate One Rep max for a given workout using the Bryzcki Formula:
     https://www.wikiwand.com/en/One-repetition_maximum
     */
    fileprivate static func oneRepMax(
        workout: Workout
    ) -> Double {
        let oneRepMax = workout.weight * (Double(36.0) / Double(37.0 - Double(workout.reps)))
        return oneRepMax
    }

    static var previews: some View {
        let result: Result<[Workout], Error> = Bundle.main.readCSV(
            from: "workoutData",
            fileExtension: "txt"
        )

        switch result {
        case .success(let workouts):
            let grouped = groupWorkouts(workouts)
            return WorkoutChartView(data: grouped[0].metadata)
        case .failure:
            fatalError()
        }

    }
}
