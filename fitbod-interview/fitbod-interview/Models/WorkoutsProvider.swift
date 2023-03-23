//
//  WorkoutsProvider.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-23.
//

import Foundation

protocol WorkoutsProvider {
    func fetchWorkouts(_ completion: @escaping (Result<[GroupedWorkouts], Error>) -> Void)
}
