//
//  TransactionListViewController.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 14/09/2024.
//

import UIKit
import Combine

class TransactionListViewController: UIViewController {
    
    @IBOutlet weak var transactionTableView: UITableView!
    var searchController: UISearchController!
    var activityIndicator: UIActivityIndicatorView!
    var vm = TransactionListViewModel(transactionService: TransactionServiceImpl())
    var cancellables = Set<AnyCancellable>()
    var transactions: [Transaction] = []
    var filteredTransactions: [Transaction] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Transaction List"
        setupTableView()
        setupSearchBar()
        setupActivityIndicator()
        bind()
        fetchTransactions()
    }
    
    func fetchTransactions() {
        showLoader()
        navigationItem.searchController = nil
        transactionTableView.isHidden = true
        vm.fetchTransactions()
    }
    
    func bind() {
        vm.listPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] output in
                guard let self else { return }
                switch output {
                case .success(let transactions):
                    hideLoader()
                    self.transactions = transactions
                    filteredTransactions = transactions
                    transactionTableView.reloadData()
                    transactionTableView.isHidden = false
                    if transactions.isEmpty {
                        navigationItem.searchController = nil
                    } else {
                        navigationItem.searchController = searchController
                    }
                case .failure(let error):
                    self.transactionTableView.isHidden = true
                    self.hideLoader()
                    self.showErrorAlert(message: error.description)
                }
                
            }
            .store(in: &cancellables)
    }
    
    func showLoader() {
        activityIndicator.startAnimating()
    }
    
    func hideLoader() {
        activityIndicator.stopAnimating()
    }
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "search transactions"
    }
    
    func setupActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    func setupTableView() {
        let cell = UINib(nibName: "TransactionCell", bundle: nil)
        transactionTableView.register(cell, forCellReuseIdentifier: "TransactionCell")
        transactionTableView.dataSource = self
    }
    
    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.fetchTransactions()
        }
        alert.addAction(okAction)
        alert.addAction(retryAction)
        
        present(alert, animated: true)
    }

}

extension TransactionListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredTransactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        cell.setup(transaction: filteredTransactions[indexPath.row])
        return cell
    }
}

extension TransactionListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
            filteredTransactions = transactions
            transactionTableView.reloadData()
            return
        }
        
        filteredTransactions = transactions.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        transactionTableView.reloadData()

    }
}
