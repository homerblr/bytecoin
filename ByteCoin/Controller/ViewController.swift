//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.


import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var currencyPicker: UIPickerView!
    @IBOutlet var currancyLabel: UILabel!
    @IBOutlet var bitcoinLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
    
    var coinManager = CoinManager()
    
}

//MARK: - Picker Extensions
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        
        coinManager.finalURL(currency: selectedCurrency)
    }
}

//MARK: - Coin manager extension
extension ViewController: CoinManagerDelegate {
    func didUpdateCoinData(_ coinManager: CoinManager, coin: CoinModel) {
        if let coinOpt = coin.lastPrice {
            DispatchQueue.main.async {
                self.bitcoinLabel.text = String(format: "%.2f", coinOpt)
            }
            
        }
        
    }
    
}

