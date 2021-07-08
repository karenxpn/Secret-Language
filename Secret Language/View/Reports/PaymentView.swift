//
//  PaymentView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import SwiftUI

struct PaymentView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var paymentVM = StoreViewModel()
    
    let birthdayDate: String

    var body: some View {
        ZStack {
            Background()
            
            ScrollView( showsIndicators: false ) {
                VStack( spacing: 20 ) {
                    
                    Spacer()
                    
                    ZStack {
                        Image("reports")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 231, height: 231)
                        
                        ZStack {
                            Circle()
                                .fill(AppColors.blueColor)
                                .frame(width: 121, height: 121)
                            
                            VStack {
                                Text( "$0.99" )
                                    .foregroundColor(.white)
                                    .font(.custom("times", size: 35))
                                    .fontWeight(.heavy)
                                
                                
                                Text( NSLocalizedString("report", comment: ""))
                                    .foregroundColor(.accentColor)
                                    .font(.custom("Avenir", size: 21))
                            }
                        }
                    }
                    
                    Text( NSLocalizedString("pay99cent", comment: ""))
                        .foregroundColor(.white)
                        .font(.custom("times", size: 22))
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 25)
                    
                    
                    Button(action: {
                        if let product = paymentVM.product(for: "com.xpn-development.Secret-Language.report") {
                            print(product)
                            paymentVM.purchaseProduct(product)
                        }
                    }, label: {
                        Text( NSLocalizedString("unlockReport", comment: ""))
                            .foregroundColor(.black)
                            .font(.custom("times", size: 16))
                            .frame(width: .greedy, height: 50)
                            .background(.accentColor)
                            .cornerRadius(25)
                    })
                    
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .stroke(Color.gray)
                                .frame(width: .greedy, height: 50)
                            
                            Text(NSLocalizedString("cancel", comment: ""))
                                .foregroundColor(.gray)
                                .font(.custom("times", size: 16))
                                .frame(width: .greedy, height: 50)
                        }
                    })
                    
                    Spacer()
                    
                    VStack(spacing: 5) {
                        Text( NSLocalizedString("rightsReserved", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 10))
                            .multilineTextAlignment(.center)
                            .lineSpacing(5)
                        
                        Link(NSLocalizedString("madeByDoejo", comment: ""), destination: URL(string: "https://doejo.com")!)
                            .foregroundColor(.blue)
                            .font(.custom("Gilroy-Regular", size: 10))
                    }
                                        
                }.padding()
                .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)

        }.navigationBarTitle("")
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("subscription", comment: "")), displayMode: .inline)
        .onAppear {
            paymentVM.birthdayDate = birthdayDate
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(birthdayDate: "Jul 1")
    }
}
