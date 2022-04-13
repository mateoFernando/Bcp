//
//  ExchangeVC.swift
//  Exchange
//
//  Created by Fernando Daniel on 7/04/22.
//

import Foundation
import UIKit

class ExchangeVC: UIViewController {

    let logoImage: UIImageView = UIImageView(image: UIImage(named: "logo"))
    var moneyInputs: MoneyInputs = MoneyInputs()

    var viewModel: CurrencyViewModel = CurrencyViewModel.sharedManager

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red: 248/255.0,
                                       green: 248/255.0,
                                       blue: 248/255.0,
                                       alpha: 1)
        logoImage.contentMode = .scaleAspectFit
        self.moneyInputs.delegate = self
        view.addSubview(logoImage)
        view.addSubview(moneyInputs)
        self.moneyInputs.setupWithSendCurrency()
    }

    override func viewWillLayoutSubviews() {
        moneyInputConstraints()
        logoConstraints()
    }

    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}

extension ExchangeVC: MoneyInputsProtocol {

    func goToListCurrencies(selectedCountry: Country, type: TypeSelected) {
        self.navigationController?.pushViewController(CurrenciesVC(selected: selectedCountry, type: type), animated: true)
    }
}

extension ExchangeVC {

    func moneyInputConstraints() {
        moneyInputs.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: moneyInputs,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: moneyInputs,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: moneyInputs,
                                                 attribute: NSLayoutConstraint.Attribute.leadingMargin,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: view,
                                                 attribute: NSLayoutConstraint.Attribute.leadingMargin,
                                                 multiplier: 1,
                                                 constant: 16)
        let trailingConstraint = NSLayoutConstraint(item: moneyInputs,
                                                  attribute: NSLayoutConstraint.Attribute.trailingMargin,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: view,
                                                  attribute: NSLayoutConstraint.Attribute.trailingMargin,
                                                  multiplier: 1,
                                                  constant: 16)
        view.addConstraints([horizontalConstraint, verticalConstraint, leadingConstraint, trailingConstraint])
    }

    func logoConstraints() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: logoImage,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: logoImage,
                                                    attribute: NSLayoutConstraint.Attribute.topMargin,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.topMargin,
                                                    multiplier: 1,
                                                    constant: 40)
        let widthConstraint = NSLayoutConstraint(item: logoImage,
                                                 attribute: NSLayoutConstraint.Attribute.width,
                                                 relatedBy: NSLayoutConstraint.Relation.equal,
                                                 toItem: nil,
                                                 attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                 multiplier: 1,
                                                 constant: 180)
        let heightConstraint = NSLayoutConstraint(item: logoImage,
                                                  attribute: NSLayoutConstraint.Attribute.height,
                                                  relatedBy: NSLayoutConstraint.Relation.equal,
                                                  toItem: nil,
                                                  attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                                  multiplier: 1,
                                                  constant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}
