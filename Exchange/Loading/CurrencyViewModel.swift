//
//  CurrencyViewModel.swift
//  Exchange
//
//  Created by Fernando Daniel on 8/04/22.
//

import Foundation

class CurrencyViewModel: NSObject {

    private static var sharedInstance: CurrencyViewModel?

    class var sharedManager : CurrencyViewModel {
        guard let sharedInstance = self.sharedInstance else {
            let sharedInstance = CurrencyViewModel()
            self.sharedInstance = sharedInstance
            return sharedInstance
        }
        return sharedInstance
    }

    private var currencies = [Country]()
    var sendCurrency: Country?
    var receiveCurrency: Country?

    var detailBuySell: String {
        if let send = sendCurrency, let receive = receiveCurrency {
            return "Compra: \(send.ratesBuy["\(receive.id)"] ?? 0) | venta: \(send.ratesSell["\(receive.id)"] ?? 0)"
        }
        return ""
    }

    func addingCurrenciesOfRawData(_ raw: CurrencyData) {

        for item in raw.currencies {
            currencies.append(item)
        }
        settingDefaultValues()
    }

    func settingDefaultValues() {
        sendCurrency = currencies.filter{$0.id == "SOL"}.first
        receiveCurrency = currencies.filter{$0.id == "USD"}.first
    }

    func listOfCurrenciesToSelect() -> [Country] {
        if let send = sendCurrency, let receive = receiveCurrency {
            var temp = currencies
            temp = temp.filter{ ($0.id != send.id) && ($0.id != receive.id) }
            return temp
        }
        return currencies
    }

    func updateSend(_ country: Country) {
        sendCurrency = country
    }
    
    func updateReceive(_ country: Country) {
        receiveCurrency = country
    }
}
