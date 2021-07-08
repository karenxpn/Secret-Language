//
//  PaymentViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 09.07.21.
//

import Combine
import StoreKit
import SwiftUI

typealias FetchCompletionHandler = ( ([SKProduct]) -> Void )
typealias PurchaseCompletionHandler = ( ( SKPaymentTransaction? ) -> Void )

class PaymentViewModel: NSObject, ObservableObject {
    private let allProductIdentifiers = Set(["com.xpn-development.Secret-Language.report"])
    
    private var completedPurchases = [String]()
    
    private var productsRequest: SKProductsRequest?
    private var fetchedProducts = [SKProduct]()
    private var fetchCompletionHandler: FetchCompletionHandler?
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    
    override init() {
        super.init()
        
        startObservingPaymentQueue()
        fetchProducts { products in
            print(products)
        }
    }
    
    private func startObservingPaymentQueue() {
        SKPaymentQueue.default().add(self)
    }
    
    private func fetchProducts(_ completion: @escaping FetchCompletionHandler ) {
        guard self.productsRequest == nil else { return }
        
        fetchCompletionHandler = completion
        
        productsRequest = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }
    
    private func buy(_ product: SKProduct, completion: @escaping PurchaseCompletionHandler ) {
        purchaseCompletionHandler = completion
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension PaymentViewModel {
    
    func product( for identifier: String ) -> SKProduct? {
        return fetchedProducts.first(where: { $0.productIdentifier == identifier })
    }
    
    func purchaseProduct( _ product: SKProduct ) {
        startObservingPaymentQueue()
        buy(product) { _ in
            
        }
    }
}


extension PaymentViewModel: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
        let invalidProducs = response.invalidProductIdentifiers
        
        guard !loadedProducts.isEmpty else {
            print("Could not load products")
            
            if !invalidProducs.isEmpty {
                print("Invalid products found: \(invalidProducs)")
            }
            
            productsRequest = nil
            return
        }
        
        // Cache the fetched products
        fetchedProducts = loadedProducts
        
        // notify anyone waiting on the product load
        DispatchQueue.main.async {
            self.fetchCompletionHandler?( loadedProducts )
            self.fetchCompletionHandler = nil
            self.productsRequest = nil
        }
    }
}

extension PaymentViewModel: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            
            var shouldFinishTransaction: Bool = false
            
            switch transaction.transactionState {
            case .purchasing, .deferred:
                break
            case .purchased, .restored:
                completedPurchases.append(transaction.payment.productIdentifier)
                shouldFinishTransaction = true
            case .failed:
                shouldFinishTransaction = true
                
            @unknown default:
                break
            }
            
            if shouldFinishTransaction {
                SKPaymentQueue.default().finishTransaction(transaction)
                DispatchQueue.main.async {
                    self.purchaseCompletionHandler?( transaction )
                    self.purchaseCompletionHandler = nil
                }
            }
        }
    }
}
