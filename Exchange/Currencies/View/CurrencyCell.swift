//
//  CurrencyCell.swift
//  Exchange
//
//  Created by Fernando Daniel on 8/04/22.
//

import Foundation
import UIKit


class CurrencyCell: UITableViewCell {

    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setupCell(_ country: Country, selectedCountry: Country) {
        self.contentImage.contentMode = .scaleAspectFit
        self.contentImage.image = UIImage(named: country.id)
        self.title.text = country.title
        self.subTitle.text = "1 \(selectedCountry.id) = \(selectedCountry.ratesBuy["\(country.id)"] ?? 0) \(country.id)"
    }
}
