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
    
    //price labels for our 3 coins
    @IBOutlet weak var btcPrice: UILabel!
    @IBOutlet weak var ethPrice: UILabel!
    @IBOutlet weak var iotaPrice: UILabel!
    
    //store price coin information in this array
    var coins = [Coin]()
    
    //price above and below variables
    @IBOutlet weak var priceBelow: UITextField!
    @IBOutlet weak var priceAbove: UITextField!
    
    
    @IBAction func addPriceAlert(_ sender: Any) {
        
    }
    
    
    
    
    
    
    
    //refresh price fetches new price data and updates the label
    @IBAction func refreshPrice(_ sender: Any) {
        fetchPriceData()
        self.btcPrice.text = self.coins[0].price_usd
        self.ethPrice.text = self.coins[1].price_usd
        self.iotaPrice.text = self.coins[3].price_usd
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPriceData();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

