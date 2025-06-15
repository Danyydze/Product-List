//
//  ProductsViewModel.swift
//  Product List
//
//  Created by Данил Марков on 14.06.2025.
//

import UIKit

class ProductsViewModel {
    private(set) var products: [Product] = []
    
    func loadProducts(complection: @escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let url = Bundle.main.url(forResource: "products", withExtension: "json"),
               let data = try? Data(contentsOf: url),
               let productsData = try? JSONDecoder().decode([Product].self, from: data) {
                self.products = products
            }
            DispatchQueue.main.async {
                complection()
            }
        }
    }
}
