//
//  Currencies.swift
//  Exchange
//
//  Created by Fernando Daniel on 7/04/22.
//

import Foundation
import UIKit

class CurrenciesVC: UIViewController, UITableViewDelegate {

    let logoImage: UIImageView = UIImageView(image: UIImage(named: "logo"))
    var viewModel: CurrencyViewModel = CurrencyViewModel.sharedManager
    let tableView = UITableView()
    let selected: Country
    let type: TypeSelected

    init (selected: Country, type: TypeSelected) {
        self.selected = selected
        self.type = type
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        logoImage.contentMode = .scaleAspectFit
        setTableView()
    }

    func setTableView() {
        view.addSubview(logoImage)
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillLayoutSubviews() {
        logoConstraints()
        tableConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: "CurrencyCell")
    }
}

extension CurrenciesVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listOfCurrenciesToSelect().count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        cell.setupCell(viewModel.listOfCurrenciesToSelect()[indexPath.row], selectedCountry: selected)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        113
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .send {
            viewModel.updateSend(viewModel.listOfCurrenciesToSelect()[indexPath.row])
        } else {
            viewModel.updateReceive(viewModel.listOfCurrenciesToSelect()[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension CurrenciesVC {

    func tableConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: logoImage.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
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
