//
//  WorkoutsViewController.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import UIKit

class WorkoutsViewController: UIViewController {

    // MARK: Private Variables

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            WorkoutTableViewCell.self,
            forCellReuseIdentifier: NSStringFromClass(
                WorkoutTableViewCell.self
            )
        )

        return tableView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()


    private var groupedWorkouts: [GroupedWorkouts]
    private var workoutsProvider: WorkoutsProvider

    // MARK: Init

    required init(workoutsProvider: WorkoutsProvider) {
        self.workoutsProvider = workoutsProvider
        self.groupedWorkouts = []

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View Controller Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        makeConstraints()


        tableView.isHidden = true
        activityIndicatorView.startAnimating()

        workoutsProvider.fetchWorkouts { [weak self] result in
            self?.tableView.isHidden = false
            self?.activityIndicatorView.stopAnimating()

            switch result {
            case .success(let workouts):
                self?.groupedWorkouts = workouts
                self?.tableView.reloadData()
            case .failure(let error):
                self?.presentAlert(with: error)
            }
        }
    }

    // MARK: - Layout

    fileprivate func makeConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WorkoutsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NSStringFromClass(WorkoutTableViewCell.self),
            for: indexPath
        )

        if let cell = cell as? WorkoutTableViewCell {
            cell.configure(with: groupedWorkouts[indexPath.row])
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedWorkouts.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return .tableRowHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let detailViewController = WorkoutsDetailViewController(
            workout: groupedWorkouts[indexPath.row]
        )

        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Constants

fileprivate extension CGFloat {
    static let tableRowHeight: CGFloat = 80.0
}
