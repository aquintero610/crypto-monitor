//
//  ViewController.swift
//  crypto-monitor
//
//  Created by Andrew Quintero on 12/10/17.
//  Copyright © 2017 Andrew Quintero. All rights reserved.
//

import UIKit

struct Coin: Decodable {
    let name: String
    let price_usd: String
}

class ViewController: UIViewController {
    var timer = Timer()
    //price labels for our 3 coins
    @IBOutlet weak var btcPrice: UILabel!
    @IBOutlet weak var ethPrice: UILabel!
    @IBOutlet weak var iotaPrice: UILabel!
    
    //store price coin information in this array
    var coins = [Coin]()
    
    //price textboxes for above and below
    @IBOutlet weak var priceBelow: UITextField!
    @IBOutlet weak var priceAbove: UITextField!
    
    //this is where we will store the price alerts
    var mPriceBelowAlert: Double = -1.0
    var mPriceAboveAlert: Double = -1.0
    
    //counter
    var mCounter: Int = 10;
    
    @IBAction func addPriceAlert(_ sender: Any) {
        mPriceBelowAlert = Double(priceBelow.text!)!
        mPriceAboveAlert = Double(priceAbove.text!)!
    }
    
    //refresh price fetches new price data and updates the label
    @IBAction func refreshPrice(_ sender: Any) {
        fetchPriceData()
        setDataPrice()
    }
    
    func setDataPrice(){
        self.btcPrice.text = self.coins[0].price_usd
        self.ethPrice.text = self.coins[1].price_usd
        self.iotaPrice.text = self.coins[3].price_usd
        print("Prices updated")
    }
    
    //fetch price data parses json file from coinmarket and updates "coins" with
    //the latest prices
    func fetchPriceData(){
      // Do any additional setup after loading the view, typically from a nib.
      let jsonURL = "https://api.coinmarketcap.com/v1/ticker/"
      let url = URL(string: jsonURL);
      URLSession.shared.dataTask(with: url!) { (data, response, error) in
        do{
            self.coins = try JSONDecoder().decode([Coin].self, from: data!)
            print(self.coins[0].name + ": " + self.coins[0].price_usd)
            print(self.coins[1].name + ": " + self.coins[1].price_usd)
            print(self.coins[3].name + ": " + self.coins[3].price_usd)
        }
        catch{
            print("ERROR");
        }
      }.resume()
    }
    
    @objc func countdownRefresh(){
        mCounter = mCounter - 1
        print(mCounter);
        if(0 == mCounter){
            mCounter = 10;
            self.fetchPriceData()
            self.setDataPrice()
            self.checkPriceAlert()
        }
    }
    
    func checkPriceAlert(){
        if(Double(coins[0].price_usd)! > mPriceAboveAlert){
            print("BTC IS ABOVE " + String(mPriceAboveAlert))
        }
        else if(Double(coins[0].price_usd)! < mPriceBelowAlert){
            print("BTC IS BELOW " + String(mPriceBelowAlert))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPriceData();

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countdownRefresh), userInfo: nil, repeats: true)
     
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}

