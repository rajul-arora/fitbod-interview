//
//  WorkoutsCSVService.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-23.
//

import Foundation

final class WorkoutsCSVService: WorkoutsProvider {

    private var filename: String
    private var fileExtension: String

    required init(filename: String, fileExtension: String) {
        self.filename = filename
        self.fileExtension = fileExtension
    }

    func fetchWorkouts(_ completion: @escaping (Result<[GroupedWorkouts], Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let result: Result<[Workout], Error> = Bundle.main.readCSV(
                from: self.filename,
                fileExtension: self.fileExtension
            )

            switch result {
            case .success(let workouts):
                let groupedWorkouts = Self.groupWorkouts(workouts)
                DispatchQueue.main.async {
                    completion(.success(groupedWorkouts))
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    fileprivate static func groupWorkouts(
        _ workouts: [Workout]
    ) -> [GroupedWorkouts] {
        let workoutsGroupedByName = Dictionary(grouping: workouts) { $0.name }

        return workoutsGroupedByName.map { key, value in
            groupedWorkouts(name: key, workouts: value)
        }
    }

    fileprivate static func groupedWorkouts(
        name: String,
        workouts: [Workout]
    ) -> GroupedWorkouts {
        let groupedByDate = Dictionary(grouping: workouts) { $0.date }

        let metadata = groupedByDate.map { key, value in
            GroupedWorkouts.Metadata(
                date: key,
                workouts: value,
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
        return workout.weight * (36.0 / (37.0 - Double(workout.reps)))
    }
}
