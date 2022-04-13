//
//  MoneyInputs.swift
//  Exchange
//
//  Created by Fernando Daniel on 8/04/22.
//

import Foundation
import UIKit

protocol MoneyInputsProtocol {
    func goToListCurrencies(selectedCountry: Country, type:TypeSelected)
}


class MoneyInputs: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var receiveButton: UIButton!
    @IBOutlet weak var sendInput: UITextField!
    @IBOutlet weak var receiveInput: UITextField!
    @IBOutlet weak var buySell: UILabel!
    @IBOutlet weak var subContentView: UIView!

    public var delegate: MoneyInputsProtocol?
    var pressType: Int = 0

    var viewModel: CurrencyViewModel = CurrencyViewModel.sharedManager

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 445, height: 223))
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit(){
        guard let view = loadViewFromNib() else { return }
        contentView = view
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        contentView.backgroundColor = UIColor(red: 248/255.0,
                                              green: 248/255.0,
                                              blue: 248/255.0,
                                              alpha: 1)

        let sendLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressSend(gesture:)))
        sendButton.addGestureRecognizer(sendLongGesture)
        let receiveLongGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressReceive(gesture:)))
        receiveButton.addGestureRecognizer(receiveLongGesture)
        sendInput.delegate = self
        receiveInput.delegate = self
        setupWithSendCurrency()
    }

    func loadViewFromNib() -> UIView? {
        let nib = Bundle.main.loadNibNamed("MoneyInputs", owner: self, options: nil)
        return nib?.first as? UIView
    }

    func setupWithSendCurrency() {

        sendButton.setTitle(viewModel.sendCurrency?.title, for: .normal)
        receiveButton.setTitle(viewModel.receiveCurrency?.title, for: .normal)
        buySell.text = viewModel.detailBuySell
        updateValues(pressType)
    }

    @objc
    func longPressSend(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            guard let country = viewModel.sendCurrency else {return}
            delegate?.goToListCurrencies(selectedCountry: country, type: .send)
            pressType = 0
        }
    }

    @objc
    func longPressReceive(gesture: UILongPressGestureRecognizer) {
        if gesture.state == UIGestureRecognizer.State.began {
            guard let country = viewModel.receiveCurrency else {return}
            delegate?.goToListCurrencies(selectedCountry: country, type: .recieve)
            pressType = 1
        }
    }
}

extension MoneyInputs: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateValues(textField.tag)
        textField.resignFirstResponder()
        return true
    }

    func updateValues(_ tag: Int) {

        if tag == 0 {
            if let text = sendInput.text, text.count > 0 {
                if let send = viewModel.sendCurrency, let receive = viewModel.receiveCurrency {
                    receiveInput.text = "\((Double(text) ?? 0)*(receive.ratesBuy["\(send.id)"] ?? 0))"
                }
            }
        }
        else if tag == 1 {
            if let text = receiveInput.text, text.count > 0 {
                if let send = viewModel.sendCurrency, let receive = viewModel.receiveCurrency {
                    sendInput.text = "\((Double(text) ?? 0)*(receive.ratesSell["\(send.id)"] ?? 0))"
                }
            }
        }
    }
}
