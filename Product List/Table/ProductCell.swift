//
//  ProductCell.swift
//  Product List
//
//  Created by Данил Марков on 15.06.2025.
//

import UIKit

protocol ProductCellDelegate: AnyObject {
    func didTapMoreButton(in cell: ProductCell, article: String, wbArticle: String)
}

class ProductCell: UITableViewCell {

    static let identifier = "ProductCell"
    weak var delegate: ProductCellDelegate?
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        return view
    }()
    
    private let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.backgroundColor = .systemGray6
        image.tintColor = .systemPurple
        return image
    }()
    
    private let categoryContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.96, alpha: 1.0)
        view.layer.cornerRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let articleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wbArticleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let originalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.text = "Цена продавца до скидки"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let originalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.text = "Скидка продавца"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let discountValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let finalPriceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0)
        label.text = "Цена со скидкой"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let finalPriceValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("•••", for: .normal)
        button.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(UIColor(red: 0.33, green: 0.33, blue: 0.35, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var currentArticle: String = ""
    private var currentWBArticle: String = ""

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(productImageView)
        categoryContainer.addSubview(categoryLabel)
        containerView.addSubview(categoryContainer)
        containerView.addSubview(nameLabel)
        containerView.addSubview(articleLabel)
        containerView.addSubview(wbArticleLabel)
        containerView.addSubview(originalPriceTitleLabel)
        containerView.addSubview(originalPriceValueLabel)
        containerView.addSubview(discountTitleLabel)
        containerView.addSubview(discountValueLabel)
        containerView.addSubview(finalPriceTitleLabel)
        containerView.addSubview(finalPriceValueLabel)
        containerView.addSubview(moreButton)
        
        originalPriceTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        discountTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        finalPriceTitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        originalPriceValueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        discountValueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        finalPriceValueLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: categoryContainer.topAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: categoryContainer.leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: categoryContainer.trailingAnchor, constant: -8),
            categoryLabel.bottomAnchor.constraint(equalTo: categoryContainer.bottomAnchor, constant: -4),
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            productImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            
            categoryContainer.topAnchor.constraint(equalTo: productImageView.topAnchor),
            categoryContainer.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            
            moreButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 15),
            moreButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            moreButton.widthAnchor.constraint(equalToConstant: 30),
            moreButton.heightAnchor.constraint(equalToConstant: 30),
            
            nameLabel.topAnchor.constraint(equalTo: categoryContainer.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: moreButton.leadingAnchor, constant: -8),
            
            articleLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            articleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            articleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            wbArticleLabel.topAnchor.constraint(equalTo: articleLabel.bottomAnchor, constant: 2),
            wbArticleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            wbArticleLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            
            originalPriceTitleLabel.topAnchor.constraint(equalTo: wbArticleLabel.bottomAnchor, constant: 16),
            originalPriceTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            originalPriceTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180),
            
            originalPriceValueLabel.firstBaselineAnchor.constraint(equalTo: originalPriceTitleLabel.firstBaselineAnchor),
            originalPriceValueLabel.leadingAnchor.constraint(equalTo: originalPriceTitleLabel.trailingAnchor, constant: 8),
            originalPriceValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16),
            
            discountTitleLabel.topAnchor.constraint(equalTo: originalPriceTitleLabel.bottomAnchor, constant: 8),
            discountTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            discountTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180),
            
            discountValueLabel.firstBaselineAnchor.constraint(equalTo: discountTitleLabel.firstBaselineAnchor),
            discountValueLabel.leadingAnchor.constraint(equalTo: discountTitleLabel.trailingAnchor, constant: 8),
            discountValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16),
            
            finalPriceTitleLabel.topAnchor.constraint(equalTo: discountTitleLabel.bottomAnchor, constant: 8),
            finalPriceTitleLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            finalPriceTitleLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 180),
            finalPriceTitleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            
            finalPriceValueLabel.firstBaselineAnchor.constraint(equalTo: finalPriceTitleLabel.firstBaselineAnchor),
            finalPriceValueLabel.leadingAnchor.constraint(equalTo: finalPriceTitleLabel.trailingAnchor, constant: 8),
            finalPriceValueLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupActions() {
        moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
    }
    
    func configure(with product: Product) {
        productImageView.image = UIImage(named: product.photo) ?? UIImage(systemName: "photo")
        categoryLabel.text = product.category.uppercased()
        nameLabel.text = product.name
        articleLabel.text = "Арт. \(product.article)"
        wbArticleLabel.text = "Арт. WB \(product.wbArticle)"
        currentArticle = product.article
        currentWBArticle = product.wbArticle
        let discountedPrice = product.discountedPrice
        originalPriceValueLabel.text = "\(product.priceWithoutDiscount.formattedPrice) ₽"
        discountValueLabel.text = "\(product.discount)%"
        finalPriceValueLabel.text = "\(discountedPrice.formattedPrice) ₽"
        originalPriceValueLabel.attributedText = nil
        finalPriceValueLabel.textColor = .black
    }
    
    @objc private func moreButtonTapped() {
        delegate?.didTapMoreButton(in: self, article: currentArticle, wbArticle: currentWBArticle)
    }
}

extension Int {
    var formattedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
