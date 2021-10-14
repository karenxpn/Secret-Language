//
//  PaymentViewModel.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 09.07.21.
//

import Combine
import StoreKit
import SwiftUI

enum IAPHandlerAlertType{
    case disabled
    case restored
    case purchased
    
    func message() -> String{
        switch self {
        case .disabled: return "Purchases are disabled in your device!"
        case .restored: return "You've successfully restored your purchase!"
        case .purchased: return "You've successfully bought this purchase!"
        }
    }
}
class PaymentViewModel: NSObject, ObservableObject {
    
    static let shared = PaymentViewModel()
    
    private let allProductIdentifiers = Credentials.appStoreProductIdentifiers
    fileprivate var productsRequest = SKProductsRequest()
    fileprivate var fetchedProducts = [SKProduct]()
    
    var purchaseStatusBlock: ((IAPHandlerAlertType) -> Void)?
    
    
    @AppStorage( "token" ) private var token: String = ""
    @AppStorage( "shouldPurchaseReport" ) private var shouldPurchase: Bool = true
    @AppStorage( "shouldSubscribe" ) private var shouldSubscribe: Bool = true
    
    @Published var paymentType: String = "report"
    
    @Published var birthdayDate: String = ""
    @Published var firstReportDate: String = ""
    @Published var secondReportDate: String = ""
    @Published var birthdayOrRelationship: Bool = false
    
    @Published var loadingPaymentProccess: Bool = false
    @Published var loadingRestoreProccess: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: PaymentServiceProtocol
    
    init(dataManager: PaymentServiceProtocol = PaymentService.shared) {
        self.dataManager = dataManager
        super.init()
        
        self.fetchAvailableProducts()
    }
    
    
    func canMakePurchases() -> Bool {  return SKPaymentQueue.canMakePayments()  }
    
    func purchaseMyProduct(index: Int){
        if fetchedProducts.count == 0 { return }
        
        if self.canMakePurchases() {
            let product = fetchedProducts[index]
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            purchaseStatusBlock?(.disabled)
        }
    }
    
    func fetchAvailableProducts(){
        
        productsRequest = SKProductsRequest(productIdentifiers: allProductIdentifiers)
        productsRequest.delegate = self
        productsRequest.start()
    }
}

extension PaymentViewModel {
    
    func product( for identifier: String ) -> SKProduct? {
        return fetchedProducts.first(where: { $0.productIdentifier == identifier } )
    }
    
    func restorePurchase() {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
}


extension PaymentViewModel: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if (response.products.count > 0) {
            fetchedProducts = response.products
        }
    }
}

extension PaymentViewModel: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                switch trans.transactionState {
                case .purchased:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    purchaseStatusBlock?(.purchased)
                    break
                    
                case .failed:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                case .restored:
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    break
                    
                default: break
                }}}
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        purchaseStatusBlock?(.restored)
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
                    if response.error == nil {
                        self.shouldPurchase = false
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
