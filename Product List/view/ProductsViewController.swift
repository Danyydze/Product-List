//
//  ProductsViewController.swift
//  Product List
//
//  Created by Данил Марков on 14.06.2025.
//

import UIKit

class ProductsViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel = ProductsViewModel()
    private let headerView = ProductsTableHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
        viewModel.loadProducts { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupUI() {
        setupTableView()
        title = "Все товары"
        view.backgroundColor = .white
        
        tableView.tableHeaderView = headerView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    private func setupActions() {
        headerView.segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .systemGray6
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        viewModel.filterProducts(by: sender.selectedSegmentIndex)
        tableView.reloadData()
    }
}

extension ProductsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredProducts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductCell.identifier,
            for: indexPath
        ) as? ProductCell else {
            return UITableViewCell()
        }

        let product = viewModel.filteredProducts[indexPath.row]
        cell.configure(with: product)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension ProductsViewController: ProductCellDelegate {
    func didTapMoreButton(in cell: ProductCell, article: String, wbArticle: String) {
        showArticleActions(article: article, wbArticle: wbArticle)
    }
    
    private func showArticleActions(article: String, wbArticle: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Скопировать артикул", style: .default) { _ in
            UIPasteboard.general.string = article
            self.showCopySuccess(message: "Артикул скопирован")
        })
        
        alert.addAction(UIAlertAction(title: "Скопировать артикул WB", style: .default) { _ in
            UIPasteboard.general.string = wbArticle
            self.showCopySuccess(message: "WB артикул скопирован")
        })
        
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func showCopySuccess(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        present(alert, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                alert.dismiss(animated: true, completion: nil)
            }
        }
    }
}
