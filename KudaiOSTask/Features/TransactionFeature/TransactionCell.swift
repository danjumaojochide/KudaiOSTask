//
//  TransactionCell.swift
//  KudaiOSTask
//
//  Created by Danjuma Nasiru on 14/09/2024.
//

import UIKit

class TransactionCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var transactionAmountLbl: UILabel!
    @IBOutlet weak var transactionDateLbl: UILabel!
    @IBOutlet weak var transactionNameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(transaction: Transaction) {
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 5
        containerView.layer.borderColor = UIColor.black.cgColor
        transactionNameLbl.text = transaction.name
        transactionDateLbl.text = transaction.formattedDate
        transactionAmountLbl.text = "₦\(transaction.amount)"
        switch transaction.transactionType {
        case .credit:
            containerView.backgroundColor = UIColor.green
        case .debit:
            containerView.backgroundColor = UIColor.red
        case .reversal:
            containerView.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        case .unknown:
            containerView.backgroundColor = UIColor.gray
        }
    }
}
