//
//  OperationModel.swift
//  lodumi
//
//  Created by Jonas S on 01/09/2021.
//

import Foundation

class Operation {
    let amount: Double
    let operationType: String
    let operationId: CUnsignedLong
    
    init(operationId: CUnsignedLong, operationType: String, amount: Double) {
        self.amount = amount
        self.operationId = operationId
        self.operationType = operationType
    }
    
    
    
}

class CashWithdrawal: Operation {
    
    let source: String
    let adress: String
    
    
    
    init(operationId: CUnsignedLong, operationType: String, amount: Double, source: String, adress: String) {
        self.source = source
        self.adress = adress
        super.init(operationId: operationId, operationType: operationType, amount: amount)

    }
}

class OtherOperation: Operation {
    
    let operationDesc: String
    

    init(operationId: CUnsignedLong, operationType: String, amount: Double, operationDesc: String) {
        self.operationDesc = operationDesc
        super.init(operationId: operationId, operationType: operationType, amount: amount)

    }
}

class ChargeOperation: Operation {
    
    let operationDesc: String
    

    
    init(operationId: CUnsignedLong, operationType: String, amount: Double, operationDesc: String) {
        self.operationDesc = operationDesc
        super.init(operationId: operationId, operationType: operationType, amount: amount)

    }
}
