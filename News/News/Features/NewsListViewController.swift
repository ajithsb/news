//
//  ViewController.swift
//  News
//
//  Created by Ajith SB
//

import UIKit

class NewsListViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var serarchBar: UISearchBar!
    
    // MARK: - Properties
    let vm = NewsListVM()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        self.hideKeyboardWhenTappedAround()
        fetchDataFromServer()
    }
    
    // MARK: - Private Methods
    
    private func setUpUI(){
        serarchBar.applyTextFieldBorder()
        serarchBar.accessibilityIdentifier = "searchField"

        tableView.register(NewsListBigTableViewCell.nib(), forCellReuseIdentifier: NewsListBigTableViewCell.identifier)
        tableView.register(NewsListSmallTableViewCell.nib(), forCellReuseIdentifier: NewsListSmallTableViewCell.identifier)
        
    }
    
    private func fetchDataFromServer(){
        if NetworkCheck.shared.isConnected && vm.isFirstPage(){
            activityIndicator.startAnimating()
        }
        vm.callNews()
        vm.onComplete = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
                self?.removeLoadingFooter()
            }
        }
        vm.onError = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
                self?.removeLoadingFooter()
                self?.showToast(message: self?.vm.errorMessage ?? "")
            }
        }
    }
    
}

// MARK: - UISearchBarDelegate

extension NewsListViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        vm.search = searchText
        vm.filterWithSearch()
    }
    
    func searchBarSearchButtonClicked(_ seachBar: UISearchBar) {
        self.view.endEditing(true)
    }

}

// MARK: - UITableView

extension NewsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.newsListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: NewsListBigTableViewCell = tableView.dequeueReusableCell(withIdentifier: NewsListBigTableViewCell.identifier) as! NewsListBigTableViewCell
            cell.config(data: vm.newsListData[indexPath.row])
            return cell
        } else {
            let cell: NewsListSmallTableViewCell = tableView.dequeueReusableCell(withIdentifier: NewsListSmallTableViewCell.identifier) as! NewsListSmallTableViewCell
            cell.config(data: vm.newsListData[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        gotoNewsDetailVC(data: vm.newsListData[indexPath.row])
    }
    
}
// MARK: - Handling paginations and footerview

extension NewsListViewController {
    func addLoadingFooter() {
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        tableView.tableFooterView = loadingIndicator
    }
    
    func removeLoadingFooter() {
        tableView.tableFooterView = nil
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !vm.isAlldataFetched(){
                addLoadingFooter()
                vm.page += 1
                fetchDataFromServer()
            }
        }
    }
}
