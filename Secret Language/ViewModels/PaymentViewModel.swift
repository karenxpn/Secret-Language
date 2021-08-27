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
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "shouldPurchaseReport" ) private var shouldPurchase: Bool = true
    @AppStorage( "shouldSubscribe" ) private var shouldSubscribe: Bool = true
    
    @Published var paymentType: String = "report"
    
    @Published var birthdayDate: String = ""
    @Published var firstReportDate: String = ""
    @Published var secondReportDate: String = ""
    @Published var birthdayOrRelationship: Bool = false
    
    @Published var loadingPaymentProccess: Bool = false
    
    private let allProductIdentifiers = Credentials.appStoreProductIdentifiers
    
    private var productsRequest: SKProductsRequest?
    private var fetchedProducts = [SKProduct]()
    private var fetchCompletionHandler: FetchCompletionHandler?
    private var purchaseCompletionHandler: PurchaseCompletionHandler?
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: PaymentServiceProtocol
    
    init(dataManager: PaymentServiceProtocol = PaymentService.shared) {
        self.dataManager = dataManager
        super.init()
        
        startObservingPaymentQueue()
        fetchProducts { _ in }
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
    
    private func buy(_ product: SKProduct , completion: @escaping PurchaseCompletionHandler ) {
        purchaseCompletionHandler = completion
        
        let payment = SKPayment(product: product)
        SKPaymentQueue.default().add(payment)
    }
}

extension PaymentViewModel {
    
    func product( for identifier: String ) -> SKProduct? {
        return fetchedProducts.first(where: { $0.productIdentifier == identifier } )
    }
    
    func purchaseProduct( _ product: SKProduct ) {
        loadingPaymentProccess = true
        
        startObservingPaymentQueue()
        buy(product) { transaction in
            if let tr = transaction {
                if tr.transactionState == .purchased || tr.transactionState == .restored {
                    if self.paymentType == "report" {
                        self.savePurchaseDetails()
                    } else {
                        self.saveSubscriptionPaymentDetails()
                    }
                }
            }
            self.loadingPaymentProccess = false
        }
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


extension PaymentViewModel: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        let loadedProducts = response.products
        
        guard !loadedProducts.isEmpty else {
            
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
                shouldFinishTransaction = true
                break
            case .failed:
                shouldFinishTransaction = true
                break
                
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
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("restored")
        print("Transactions count = \(queue.transactions.count)" )
        print("Transactions = \(queue.transactions)")
        print("Queue = \(queue)")
    }
}

extension PaymentViewModel {
    func savePurchaseDetails() {
        
        dataManager.fetchReceiptData { receipt in
            self.dataManager.postPaymentStatus(token: self.token,
                                               receipt: receipt,
                                               reportDate: self.birthdayDate,
                                               firstReportDate: self.firstReportDate,
                                               secondReportDate: self.secondReportDate,
                                               birthdayOrRelationship: self.birthdayOrRelationship)
                .sink { response in
                    self.shouldPurchase = false
                    if response.error == nil {
                        NotificationCenter.default.post(name: Notification.Name("reloadReport"), object: nil)
                    }
                }.store(in: &self.cancellableSet)
        }
    }
    
    func saveSubscriptionPaymentDetails() {
        dataManager.fetchReceiptData { receipt in
            self.dataManager.postReceiptDataToServer(token: self.token, receipt: receipt)
                .sink { response in
                    if response.error == nil {
                        self.shouldSubscribe = false
                        NotificationCenter.default.post(name: Notification.Name("reloadChats"), object: nil)
                    }
                }.store(in: &self.cancellableSet)
        }
    }
    
    func checkSubscriptionStatus() {
        dataManager.verifyUserSubscriptionStatus(token: token)
            .sink { _ in
            }.store(in: &cancellableSet)
    }
}
