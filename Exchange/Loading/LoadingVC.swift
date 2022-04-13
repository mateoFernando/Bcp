//
//  LoadingVC.swift
//  Exchange
//
//  Created by Fernando Daniel on 7/04/22.
//

import Foundation
import UIKit

class LoadingVC: UIViewController {

    let activity: UIActivityIndicatorView = UIActivityIndicatorView(style: .medium)
    let logoImage: UIImageView = UIImageView(image: UIImage(named: "logo"))
    var manager: CurrencyViewModel = CurrencyViewModel.sharedManager

    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = UIColor(red: 248/255.0,
                                       green: 248/255.0,
                                       blue: 248/255.0,
                                       alpha: 1)
        activity.color = .systemBlue
        activity.center = view.center
        logoImage.contentMode = .scaleAspectFit
        view.addSubview(logoImage)
        view.addSubview(activity)

        activity.startAnimating()
    }

    override func viewWillLayoutSubviews() {
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        activity.translatesAutoresizingMaskIntoConstraints = false

        let horizontalConstraint = NSLayoutConstraint(item: logoImage,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      relatedBy: NSLayoutConstraint.Relation.equal,
                                                      toItem: view,
                                                      attribute: NSLayoutConstraint.Attribute.centerX,
                                                      multiplier: 1,
                                                      constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: logoImage,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                                    toItem: view,
                                                    attribute: NSLayoutConstraint.Attribute.centerY,
                                                    multiplier: 1,
                                                    constant: 0)
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

        let actiHorizontal = NSLayoutConstraint(item: activity,
                                                attribute: NSLayoutConstraint.Attribute.centerX,
                                                relatedBy: NSLayoutConstraint.Relation.equal,
                                                toItem: logoImage,
                                                attribute: NSLayoutConstraint.Attribute.centerX,
                                                multiplier: 1,
                                                constant: 0)
        let actiVertical = NSLayoutConstraint(item: activity,
                                              attribute: NSLayoutConstraint.Attribute.top,
                                              relatedBy: NSLayoutConstraint.Relation.equal,
                                              toItem: logoImage,
                                              attribute: NSLayoutConstraint.Attribute.bottom,
                                              multiplier: 1,
                                              constant: 16)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint, actiHorizontal, actiVertical])
    }

    override func viewDidLoad() {

        loadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.activity.stopAnimating()
            let vc = ExchangeVC()
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func loadData() {
        if let data = FileLoader.readLocalFile("data") {
            let rawData = FileLoader.loadJson(data)
            manager.addingCurrenciesOfRawData(rawData)
        }
    }
}
