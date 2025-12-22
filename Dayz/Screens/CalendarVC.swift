//
//  CalendarVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 2.12.2025.
//

import UIKit

final class CalendarVC: UIViewController {
    
    let tableView = UITableView()
    
    let intervals: [(start: Int, end: Int)] = [
        (6, 12),
        (12, 13),
        (18, 24),
        (0, 6)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        tableView.register(DZTimeIntervalCell.self, forCellReuseIdentifier: DZTimeIntervalCell.reuseID)
    }
}

extension CalendarVC: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let interval = intervals[indexPath.row]

        let intervalMinutes = (interval.end - interval.start) * 60

        let minCellHeight: CGFloat = 44
        let maxCellHeight: CGFloat = UIScreen.main.bounds.height * 0.22

        let maxIntervalMinutes: CGFloat = 6 * 60

        let ratio = CGFloat(intervalMinutes) / maxIntervalMinutes

        let calculatedHeight =
            minCellHeight + ratio * (maxCellHeight - minCellHeight)

        return round(calculatedHeight)
    }
}

extension CalendarVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        intervals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DZTimeIntervalCell.reuseID, for: indexPath) as! DZTimeIntervalCell
        
        let interval = intervals[indexPath.row]
        
        cell.configure(startHour: interval.start, endHour: interval.end, activityName: nil)
        return cell
    }
}
