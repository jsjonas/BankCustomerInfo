//
//  ViewController.swift
//  lodumi
//
//  Created by Jonas S on 01/09/2021.
//

import UIKit
import AudioToolbox


class ViewController: UIViewController {
    
    
    private var viewModel = dataViewModel()
    private var tempId: CUnsignedLong?
    private var filteredData: [Operation] = []
    var filterActive = false

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var opTableView: UITableView!
    
    override func viewDidLoad() {
        filteredData = viewModel.operations
        
        super.viewDidLoad()

    }
    
    
    
    func getGesture(operation: Operation) -> UITapGestureRecognizer {
        let tapGesture : customTap = customTap(target: self, action: #selector(performSegue(sender:)))
        tapGesture.tapOperation = operation
        tapGesture.numberOfTapsRequired = 1
        return tapGesture
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! operationIdViewController
        destinationVC.operationId = tempId!
    }
    
    @objc func performSegue(sender: Any) -> Void {
        // little click effect
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }

        
        let tag = sender as? customTap
        tempId = tag?.tapOperation?.operationId
        AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }

        performSegue(withIdentifier: "toIDOperation", sender: self)
    }
    
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterActive ? filteredData.count : viewModel.operations.count
        
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let operation = filterActive ? filteredData[indexPath.row] : viewModel.operations[indexPath.row]

        switch operation.operationType {
        case "CASH_WITHDRAWAL":
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cash_widthdraw_cell") as! WidthdrawCell
            cell.setOperation(operation: operation as! CashWithdrawal)
            
            cell.addGestureRecognizer(getGesture(operation: operation))
            cell.isUserInteractionEnabled = true
            
            return cell
            
        case "CHARGE":
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "charge_cell") as! ChargeCell
            cell.isUserInteractionEnabled = true
            cell.setOperation(operation: operation as! ChargeOperation)
            
            cell.infoImage.isUserInteractionEnabled = true
            cell.infoImage.addGestureRecognizer(getGesture(operation: operation))
            
            return cell
            
        default:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "other_cell") as! OtherCell
            cell.setOperation(operation: operation as! OtherOperation)
            
            cell.iconInfo.isUserInteractionEnabled = true
            cell.iconInfo.addGestureRecognizer(getGesture(operation: operation))
            
            
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterItems(text: searchBar.text)
    }
    
    func filterItems(text: String?) {
        guard let searchText = text else {
                    filterActive = false
                    self.opTableView.reloadData()
                    return
        }
        
        filteredData = viewModel.operations.filter({ (item) -> Bool in
            switch type(of: item) {
            case is CashWithdrawal.Type:
                let myItem = item as! CashWithdrawal
                return myItem.adress.lowercased().hasPrefix(searchText.lowercased())
                    || myItem.source.lowercased().hasPrefix(searchText.lowercased())
                    || myItem.amount.string.lowercased().lowercased().hasPrefix(searchText.lowercased())
            case is ChargeOperation.Type:
                let myItem = item as! ChargeOperation
                return myItem.operationDesc.lowercased().hasPrefix(searchText.lowercased())
                    || myItem.amount.string.lowercased().hasPrefix(searchText.lowercased())
            case is OtherOperation.Type:
                let myItem = item as! OtherOperation
                return myItem.operationDesc.lowercased().hasPrefix(searchText.lowercased())
                    || myItem.amount.string.lowercased().lowercased().hasPrefix(searchText.lowercased())
            default:
                return false
            }
            
        })

        filterActive = true

        self.opTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterActive = false
        self.opTableView.reloadData()
        searchBar.endEditing(true)
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}


class customTap: UITapGestureRecognizer {
    var tapOperation: Operation?
}
