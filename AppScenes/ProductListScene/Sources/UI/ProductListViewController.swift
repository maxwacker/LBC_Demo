//
//  ProductListViewController.swift
//  ProductListScene
//
//  Created by maxime wacker on 27/03/2021.
//

import UIKit

protocol ProductListCelling: AnyObject {
    func updateImage(data: Data)
    func updateMain(_ mainViewModel: ProductCellMainViewModel)
}


protocol ProductListCellFactoring {
    func makeProductListCell(
        at indexPath: IndexPath,
        in tableView: UITableView
    ) -> ProductListCelling?
}

public protocol ProductListInteractoring {
    var productsCount: Int {get}
    //func productID(at row: Int) -> UInt?
    //func dataStoreUpdated()
}

final class ProductListViewController: UITableViewController {
    private let _cellFactory: ProductListCellFactoring
    private let _interactor: ProductListInteractoring


    public init(
        interactor: ProductListInteractoring,
        cellFactory: ProductListCellFactoring
    ) {
        self._cellFactory = cellFactory
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
    }
    
    // MARK: - Table view data source
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _interactor.productsCount
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return (_cellFactory.makeProductListCell(at: indexPath, in: tableView) as? UITableViewCell) ?? UITableViewCell()
    }
    
}


extension ProductListViewController: ProductListViewControllering {
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
