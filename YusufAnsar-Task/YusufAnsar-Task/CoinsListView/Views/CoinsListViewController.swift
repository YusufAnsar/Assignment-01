//
//  CoinsListViewController.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import UIKit

final class CoinsListViewController: UIViewController {

    private let viewModel: CoinsListViewModelProtocol
    private lazy var searchController = UISearchController(searchResultsController: nil)

    private lazy var coinsTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CryptoCoinTableViewCell.self,
                      forCellReuseIdentifier: CellIdentifiers.coinCell.value)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()

    private var filterContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()

    private var filterOptionsCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(FilterOptionCollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifiers.filterOptionCell.value)
        return collectionView
    }()

    private var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicatorView
    }()

    init(viewModel: CoinsListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.coinsListView = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupFilterView()
        createSearchBar()
        setupActivityIndicatorView()
        viewModel.fetchCryptoCoins()
    }

    private func setupUI() {
        title = StringConstants.coinsListTitle.value
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(coinsTableView)
        view.addSubview(filterContainerView)
        view.addSubview(activityIndicatorView)
        coinsTableView.isHidden = true
        filterContainerView.isHidden = true
        activityIndicatorView.isHidden = true
    }

    private func setupFilterView() {
        filterContainerView.addSubview(filterOptionsCollectionView)
        filterOptionsCollectionView.dataSource = self
        filterOptionsCollectionView.delegate = self
        var height: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ?  70 : 130
        let safeAreaInsets = UIApplication.safeAreaInsets
        height += safeAreaInsets.bottom
        NSLayoutConstraint.activate([
            filterContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            filterContainerView.heightAnchor.constraint(equalToConstant: height),

            filterOptionsCollectionView.topAnchor.constraint(equalTo: filterContainerView.topAnchor, constant: 10),
            filterOptionsCollectionView.leadingAnchor.constraint(equalTo: filterContainerView.leadingAnchor, constant: 10),
            filterOptionsCollectionView.trailingAnchor.constraint(equalTo: filterContainerView.trailingAnchor, constant: -10),
            filterOptionsCollectionView.bottomAnchor.constraint(equalTo: filterContainerView.bottomAnchor, constant: -10),
        ])
    }

    private func setupTableView() {
        NSLayoutConstraint.activate([
            coinsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            coinsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            coinsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            coinsTableView.bottomAnchor.constraint(equalTo: filterContainerView.topAnchor, constant: 0)
        ])
        coinsTableView.dataSource = self
        coinsTableView.delegate = self
    }

    private func setupActivityIndicatorView() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func createSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search by name or symbol"
    }
}

extension CoinsListViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptoCoins.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.coinCell.value,
                                                            for: indexPath) as? CryptoCoinTableViewCell else {
            fatalError("Failed to dequeue: CryptoCoinTableViewCell")
        }
        let cryptoCoin = viewModel.cryptoCoins[indexPath.row]
        cell.configure(with: cryptoCoin)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coinsTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CoinsListViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FilterOption.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifiers.filterOptionCell.value, for: indexPath) as? FilterOptionCollectionViewCell else {
            fatalError("Failed to dequeue: CryptoCoinTableViewCell")
        }
        let filterOption = FilterOption.allCases[indexPath.item]
        let isSelected = viewModel.appliedFilters.contains(filterOption)
        cell.configure(with: filterOption, isSelected: isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didClickFilterOption(at: indexPath.item)
        // reload with animation
        collectionView.performBatchUpdates {
            collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
}

extension CoinsListViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.didSearch(forSearchText: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didSearch(forSearchText: searchBar.text ?? "")
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.didSearch(forSearchText: "")
    }

}

extension CoinsListViewController: CoinsListViewProtocol {

    func showErrorAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func reloadScreen() {
        DispatchQueue.main.async {
            self.coinsTableView.reloadData()
            self.filterOptionsCollectionView.reloadData()
        }
    }

    func showScreenLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }

    func hideScreenLoader() {
        DispatchQueue.main.async {
            self.activityIndicatorView.stopAnimating()
            self.activityIndicatorView.isHidden = true
        }
    }

    func refreshScreen() {
        DispatchQueue.main.async {
            self.filterContainerView.isHidden = false
            self.coinsTableView.isHidden = false
            self.coinsTableView.reloadData()
            self.filterOptionsCollectionView.reloadData()
        }
    }
}
