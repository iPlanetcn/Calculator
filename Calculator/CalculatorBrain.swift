//
//  CalculatorModel.swift
//  Calculator
//
//  Created by John Lee on 4/30/16.
//  Copyright © 2016 John. All rights reserved.
//
import Foundation

class CalculatorBrain {
    fileprivate var accumulator = 0.0
    fileprivate var operations:Dictionary<String,Operation> = [
        "π": Operation.constant(Double.pi),
        "e": Operation.constant(M_E),
        "√": Operation.unaryOperation(sqrt),
        "cos": Operation.unaryOperation(cos),
        "×": Operation.binaryOperation({$0 * $1}),
        "÷": Operation.binaryOperation({$0 / $1}),
        "+": Operation.binaryOperation({$0 + $1}),
        "−": Operation.binaryOperation({$0 - $1}),
        "=": Operation.equals
    ]
    
    fileprivate enum Operation{
        case constant(Double)
        case unaryOperation((Double)->Double)
        case binaryOperation((Double,Double)->Double)
        case equals
    }
    
    func setOperand(_ operand:Double) {
        accumulator = operand
    }
    
    func performOperation(_ symbol:String){
        if let operation = operations[symbol]{
            switch operation {
            case .constant(let value):accumulator = value
            case .unaryOperation(let function):accumulator = function(accumulator)
            case .binaryOperation(let function):pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .equals:
                if pending != nil {
                    accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
                    pending = nil
                }
            }
        }
    }
    
    fileprivate var pending: PendingBinaryOperationInfo?
    
    fileprivate struct PendingBinaryOperationInfo {
        var binaryFunction: (Double,Double)->Double
        var firstOperand: Double
        
    }
    
    var reslut: Double {
        get {
            return accumulator
        }
    }
    
    
}
