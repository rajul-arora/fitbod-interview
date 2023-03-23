//
//  WorkoutsDetailViewController.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import UIKit
import SwiftUI

class WorkoutsDetailViewController: UIViewController {

    // MARK: Private Varables

    private var groupedWorkout: GroupedWorkouts

    private lazy var titleLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20.0)
        label.textColor = .label
        label.text = self.groupedWorkout.name
        return label
    }()

    private lazy var subtitleLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12.0)
        label.textColor = .secondaryLabel
        label.text = "One Rep Max • lbs"
        return label
    }()

    private lazy var weightLabel: UILabel = { [unowned self] in
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 34.0)
        label.textColor = .label
        label.textAlignment = .right
        label.text = "\(Int(self.groupedWorkout.oneRepMax))"
        return label
    }()

    private lazy var chartViewController: UIViewController = { [unowned self] in
        let chartView = WorkoutChartView(data: self.groupedWorkout.metadata)
        let viewController = UIHostingController(rootView: chartView)
        let swiftuiView = viewController.view!
        swiftuiView.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()

    // MARK: Init

    required init(workout: GroupedWorkouts) {
        self.groupedWorkout = workout
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Controller Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        navigationItem.leftBarButtonItem = .back { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(weightLabel)

        addChild(chartViewController)
        view.addSubview(chartViewController.view)
        chartViewController.didMove(toParent: self)
        makeConstraints()
    }

    // MARK: Layout

    fileprivate func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),

            weightLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            weightLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            weightLabel.widthAnchor.constraint(equalToConstant: 100.0),

            chartViewController.view.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16.0),
            chartViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chartViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chartViewController.view.heightAnchor.constraint(equalToConstant: 300.0)
        ])
    }
}
