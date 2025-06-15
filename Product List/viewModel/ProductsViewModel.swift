//
//  ProductsViewModel.swift
//  Product List
//
//  Created by Данил Марков on 14.06.2025.
//

import UIKit

class ProductsViewModel {
    private(set) var allProducts: [Product] = []
    private(set) var filteredProducts: [Product] = []
    
    func loadProducts(completion: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                if let url = Bundle.main.url(forResource: "products", withExtension: "json"),
                   let data = try? Data(contentsOf: url),
                   let productsData = try? JSONDecoder().decode([Product].self, from: data) {
                    self.allProducts = productsData
                    self.filteredProducts = productsData
                }
            } catch {
                print("Error loading products: \(error)")
            }
            DispatchQueue.main.async {
                completion()
            }
        }
    }
    
    func filterProducts(by segmentIndex: Int) {
        switch segmentIndex {
        case 0:
            filteredProducts = allProducts
        case 1:
            filteredProducts = allProducts.filter { $0.discount == 0 }
        default:
            filteredProducts = allProducts
        }
    }
}
