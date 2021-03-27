//
//  ProductListViewController.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import UIKit

public protocol ProductListInteractoring {
    func loadProducts()
}

final class ProductListViewController: UITableViewController {
    private let _interactor: ProductListInteractoring

    private var _viewModel: ProductListViewModel?
    
    public init(interactor:ProductListInteractoring) {
        self._interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        _interactor.loadProducts()
    }
    
    // MARK: - Table view data source
    public override func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return _viewModel?.count ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListCell") ?? UITableViewCell(style: .value1, reuseIdentifier: "ProductListCell")
      
      let row = indexPath.row
      cell.textLabel?.text = _viewModel?[row].title
      //cell.textLabel?.numberOfLines = 0
      cell.detailTextLabel?.text = _viewModel?[row].price
      return cell
    }
}


extension ProductListViewController: ProductListViewControllering {
    func viewModelUpdated(_ new: ProductListViewModel) {
        self._viewModel = new
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
