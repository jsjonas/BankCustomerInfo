//
//  ViewModel.swift
//  lodumi
//
//  Created by Jonas S on 02/09/2021.
//

import UIKit

class dataViewModel {
    var operations: [Operation]

    init() {
        operations = []
        configureData()
    }
    
    func configureData() {
      let data = getDataFromFile("myjson")
      parseData(data: data!)
    }
    
    public func getDataFromFile(_ filename: String) -> Data? {
       @objc class TestClass: NSObject { }
       let bundle = Bundle(for: TestClass.self)
       if let path = bundle.path(forResource: filename, ofType: "json") {
          return (try? Data(contentsOf: URL(fileURLWithPath: path)))
       }
       return nil
    }
    
    public func parseData(data: Data){
        do {
            if let json = try JSONSerialization.jsonObject(with: data) as? [String: Any], let body = json["operations"] as? [[String:Any]] {
                
                for item in body {
                    guard let typeOperation = item["operationType"] as? String else {
                                 return
                    }
                    switch typeOperation {
                    case "CASH_WITHDRAWAL":
                        let optype = item["operationType"] as? String
                        let amount = item["amount"] as? Double
                        let source = item["source"] as? String
                        let adress = item["address"] as? String
                        let opId = item["operationId"] as? CUnsignedLong
                        let cash = CashWithdrawal(operationId: opId!, operationType: optype!, amount: amount!, source: source!, adress: adress!)
                        operations.append(cash)
                        

                        break
                    case "CHARGE":
                        let optype = item["operationType"] as? String
                        let amount = item["amount"] as? Double
                        let desc = item["operationDesc"] as? String
                        let opId = item["operationId"] as? CUnsignedLong
                        let cash = ChargeOperation(operationId: opId!, operationType: optype!, amount: amount!, operationDesc: desc!)
                        operations.append(cash)
                        break
                    case "SAVING_WITHDRAWAL", "REFUND", "SALARY" :
                        let optype = item["operationType"] as? String
                        let amount = item["amount"] as? Double
                        let desc = item["operationDesc"] as? String
                        let opId = item["operationId"] as? CUnsignedLong
                        let cash = OtherOperation(operationId: opId!, operationType: optype!, amount: amount!, operationDesc: desc!)
                        operations.append(cash)
                        
                        break
                        
                    default:
                        break
                    }

                    print(item)


                }
                
            }
        }
        catch {
            print(error)
        }
    }
}
