//
//  Model.swift
//  Product List
//
//  Created by Данил Марков on 14.06.2025.
//

struct Product: Decodable {
    let photo: String
    let name: String
    let category: String
    let discount: Int
    let priceWithoutDiscount: Int
    let article: String
    let wbArticle: String
    
    var discountedPrice: Int {
        return priceWithoutDiscount * (100 - discount)/100
    }
}
