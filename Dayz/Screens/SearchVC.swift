//
//  SearchVC.swift
//  Dayz
//
//  Created by Zeynep Betül Kaya on 3.12.2025.
//

import UIKit
import FirebaseFirestore

class SearchVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var tableView = UITableView()
    
    private var users: [PublicUser] = [] // The table view is just a list of things what are we showing.
    private var dataSource: UITableViewDiffableDataSource<Section, PublicUser>!
    private var lastDocument: DocumentSnapshot?
    private var isLoading = false
    private var currentQuery: String = ""
    private var emptyStateView: DZEmptyStateView?
    
    struct Cells {
        static let searchCell = "SearchCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        configureSearchController()
        configureTableView()
        configureDataSource()
        createDismissKeyboardTapGesture()
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, PublicUser>(tableView: tableView, cellProvider: { tableView, indexPath, publicUser in
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.searchCell, for: indexPath) as! SearchCell
            cell.configure(with: publicUser)
            return cell
        })
    }
    
    func updateData(users: [PublicUser], animate: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, PublicUser>()
        snapshot.appendSections([.main])
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: animate)
    }
    
    func createDismissKeyboardTapGesture() {
            let recognizer = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
            view.addGestureRecognizer(recognizer)
        }

    func searchUsers(query: String) {
        /* used self. self in this case is our SearchVC.
         our network manager has a strong reference to SearchVC. This could cause a memory leak.
         to make this self weak, add [weak self]. Now self can be nil, so add ?
         If we dont want to use self?. first need to unwrap self.
         */
        
        currentQuery = query
        isLoading = true
        lastDocument = nil
        
        showLoadingView()
        
        NetworkManager.shared.searchUsers(usernamePrefix: query) { [weak self] result in
            guard let self = self else { return }
            // if it is old query do nothing
            guard query == self.currentQuery else { return }

            DispatchQueue.main.async {
                self.isLoading = false
                self.dismissLoadingView()

                switch result {
                case .success(let (users, lastDoc)):
                    self.emptyStateView?.removeFromSuperview()
                    self.emptyStateView = nil
                    
                    if users.isEmpty {
                        self.showEmptyStateView(with: "No users found", in: self.view)
                        return
                    }
                    
                    self.lastDocument = lastDoc
                    self.updateData(users: users, animate: false)

                case .failure(let error):
                    self.presentDZAlertOnMainThread(title: "Error", message: error.rawValue, buttonTitle: "OK", buttonTitleSec: nil)
                }
            }
        }
    }

    func loadNextPage() {
        // cursor-based pagination
        guard !isLoading, let lastDocument = lastDocument, currentQuery.count >= 3 else { return }
        let text = currentQuery
        isLoading = true
        
        showLoadingView()
        
        NetworkManager.shared.searchUsers(usernamePrefix: text, lastDocument: lastDocument) { [weak self] result in
            guard let self = self else { return }
            guard text == self.currentQuery else { return }

            DispatchQueue.main.async {
                self.isLoading = false
                self.dismissLoadingView()
                
                if case .success(let (users, lastDoc)) = result {
                    self.lastDocument = lastDoc
                    self.appendData(users: users)
                }
            }
        }
    }

    func appendData(users: [PublicUser]) {
        var snapshot = dataSource.snapshot()
        snapshot.appendItems(users)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func configureSearchController() {
        let searchController                   = UISearchController()
        searchController.searchResultsUpdater  = self
        searchController.searchBar.delegate    = self
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController        = searchController
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        tableView.delegate = self
        tableView.rowHeight = 50
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: Cells.searchCell)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension SearchVC: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // Trigger pagination after the user finishes dragging
        // to reduce unnecessary API calls.
        
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 1.5 {
            loadNextPage()
        }
    }
}

extension SearchVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text?.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        
        if text.isEmpty {
            currentQuery = ""
            updateData(users: [], animate: false)
            emptyStateView?.removeFromSuperview()
            emptyStateView = nil
            return
        }
        
        guard text.count >= 3 else {
            return
        }
        
        guard text != currentQuery else {
            return
        }
        
        searchUsers(query: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentQuery = ""
        lastDocument = nil
        isLoading = false
        
        updateData(users: [], animate: false)
        
        emptyStateView?.removeFromSuperview()
        emptyStateView = nil
        
        searchBar.resignFirstResponder()
    }
}
