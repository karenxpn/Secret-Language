//
//  MonthlySubscriptionView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 20.07.21.
//

import SwiftUI

struct MonthlySubscriptionView: View {
    @StateObject var paymentVM = PaymentViewModel.shared
    
    var body: some View {
        
        ZStack {
            Background()
            
            ScrollView( showsIndicators: false ) {
                
                ZStack {
                    Image("monthlySubscriptionTopIcon")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 230, height: 230)
                    
                    ZStack {
                        Circle()
                            .fill(AppColors.blueColor)
                            .frame(width: 121, height: 121)
                        
                        VStack {
                            Text( "$9.99" )
                                .foregroundColor(.white)
                                .font(.custom("times", size: 35))
                                .fontWeight(.heavy)
                            
                            Text( NSLocalizedString("monthly", comment: ""))
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Avenir", size: 21))
                        }
                    }
                }.padding(.top)
                
                VStack( spacing: 30) {
                    Text( NSLocalizedString("seeHowYouAreMatched", comment: "") )
                        .foregroundColor(.white)
                        .font(.custom("Avenir", size: 16))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    
                    Text( NSLocalizedString("getPremium", comment: ""))
                        .foregroundColor(AppColors.accentColor)
                        .font(.custom("Avenir", size: 16))
                        .multilineTextAlignment(.center)
                }.padding()
                .fixedSize(horizontal: false, vertical: true)
                
                VStack( spacing: 15 ) {
                    Button(action: {
                        paymentVM.loadingPaymentProccess = true
                        paymentVM.purchaseMyProduct(index: 1)
                    }, label: {
                        if paymentVM.loadingPaymentProccess {
                            ProgressView()
                                .frame(width: .greedy, height: 50)
                                .background(AppColors.accentColor)
                                .cornerRadius(25)
                        }  else {
                            Text( NSLocalizedString("subscribe", comment: ""))
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                                .fontWeight(.semibold)
                                .frame(width: .greedy, height: 50)
                                .background(AppColors.accentColor)
                                .cornerRadius(25)
                        }
                    }).disabled(paymentVM.loadingPaymentProccess)
                    
                    Button(action: {
                        paymentVM.loadingRestoreProccess = true
                        paymentVM.restorePurchase()
                    }, label: {
                        
                        if paymentVM.loadingRestoreProccess {
                            ProgressView()
                                .frame(width: .greedy, height: 50)
                                .background(.accentColor)
                                .cornerRadius(25)
                        }  else {
                            Text( NSLocalizedString("restore", comment: ""))
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("times", size: 16))
                                .fontWeight(.semibold)
                                .frame(width: .greedy, height: 50)
                                .background(RoundedRectangle(cornerRadius: 25.0).strokeBorder(AppColors.accentColor, lineWidth: 2))
                                .cornerRadius(25)
                        }
                    }).disabled(paymentVM.loadingRestoreProccess)
                }.padding()
                
                AllRightsReservedMadeByDoejo()
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                
            }.padding(.top, 1)
        }.navigationBarTitle("")
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("subscription", comment: "")), displayMode: .inline)
        .onAppear {
            paymentVM.paymentType = "monthly"
            paymentVM.purchaseStatusBlock = {(type) in
                paymentVM.loadingPaymentProccess = false
                paymentVM.loadingRestoreProccess = false

                if type == .purchased || type == .restored {
                    paymentVM.saveSubscriptionPaymentDetails()
                }
            }
        }
    }
}

struct MonthlySubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySubscriptionView()
    }
}
