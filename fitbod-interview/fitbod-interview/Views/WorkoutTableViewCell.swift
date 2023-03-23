//
//  WorkoutTableViewCell.swift
//  fitbod-interview
//
//  Created by Rajul Arora on 2023-03-19.
//

import UIKit

final class WorkoutTableViewCell: UITableViewCell {

    // MARK: Private Variables

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: .titleFontSize)
        label.textColor = .label
        return label
    }()

    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: .subtitleFontSize)
        label.textColor = .secondaryLabel
        label.text = .subtitleText
        return label
    }()

    private lazy var weightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: .weightLabelFontSize)
        label.textColor = .label
        label.textAlignment = .right
        return label
    }()

    // MARK: Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(weightLabel)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public Methods

    func configure(with workouts: GroupedWorkouts) {
        titleLabel.text = workouts.name
        weightLabel.text = "\(Int(workouts.oneRepMax))"
    }

    // MARK: Constraints

    fileprivate func makeConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: .padding),
            titleLabel.topAnchor.constraint(equalTo: weightLabel.topAnchor),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            weightLabel.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            weightLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -.padding),
            weightLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weightLabel.widthAnchor.constraint(equalToConstant: .weightLabelWidth),
        ])
    }
}

// MARK: - Constants

fileprivate extension CGFloat {
    static let padding: CGFloat = 16.0
    static let weightLabelWidth: CGFloat = 100.0
    static let titleFontSize: CGFloat = 20.0
    static let subtitleFontSize: CGFloat = 12.0
    static let weightLabelFontSize: CGFloat = 36.0
}

fileprivate extension String {
    static let subtitleText: String = "One Rep Max • lbs"
}
