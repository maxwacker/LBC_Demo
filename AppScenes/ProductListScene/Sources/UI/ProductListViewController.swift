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
        
        
        tableView.rowHeight = 100.0
        tableView.register(
            ProductListCell.self,
            forCellReuseIdentifier: String(describing: type(of: ProductListCell.self)))

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
        let cell: ProductListCell = tableView.dequeueReusableCell(withIdentifier: String(describing: type(of: ProductListCell.self)), for: indexPath) as! ProductListCell
        
        let row = indexPath.row
        cell.productItem =  _viewModel?[row]
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
