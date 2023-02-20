//
//  CoinTableViewController.swift
//  CoinBrowser
//
//  Created by Chase on 2/20/23.
//

import UIKit

class CoinTableViewController: UITableViewController {

    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoinController.fetchCoins { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinController.coins.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        
        let coin = CoinController.coins[indexPath.row]

        var config = cell.defaultContentConfiguration()
        config.text = coin.name
        config.secondaryText = "Symbol \(coin.symbol), id: \(coin.id)"
        cell.contentConfiguration = config

        return cell
    }
}
