//
//  Withdrawalcell.swift
//  lodumi
//
//  Created by Jonas S on 01/09/2021.
//

import Foundation
import UIKit

class WidthdrawCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!


    func setOperation(operation: CashWithdrawal) -> Void {
        sourceLabel.text = operation.source
        adressLabel.text =  operation.adress
        amountLabel.text = "$ \(operation.amount)"
    }
    

}

class ChargeCell: UITableViewCell {

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var opDesc: UILabel!
    @IBOutlet weak var infoImage: UIImageView!
    
    
    func setOperation(operation: ChargeOperation) -> Void {
        opDesc.text = operation.operationDesc
        amount.text = "$ \(operation.amount)"
    }


}

class OtherCell: UITableViewCell {

    @IBOutlet weak var iconInfo: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    

    
    func setOperation(operation: OtherOperation) -> Void {
        descLabel.text = operation.operationDesc
        amountLabel.text = "$ \(operation.amount)"
    }

}
