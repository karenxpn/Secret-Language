//
//  Reports.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Reports: View {
    @StateObject var reportVM = ReportViewModel()
    @State private var fullscreen: Bool = false
    @State private var showFullscreenReportOne: Bool = false
    @State private var showFullscreenReportTwo: Bool = false
    
    @State private var birthdayOrRelationship: Bool = false // false -> birthday, true -> relationship
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                NavigationLink(destination: PaymentOrReportDetectionView(birthdayOrRelationship: $birthdayOrRelationship).environmentObject(reportVM), isActive: $reportVM.navigate) {
                    EmptyView()
                }.hidden()
                
                ScrollView( showsIndicators: false ) {
                    
                    VStack ( spacing: 10 ) {
                        
                        Text( "Secret Language\n of Birthdays & Relationships" )
                            .foregroundColor(.white)
                            .font(.custom("SignPainter", size: 22))
                            .multilineTextAlignment(.center)
                        
                        Text( "Find Yourself, Connect With Others." )
                            .foregroundColor(.gray )
                            .font(.custom("times", size: 22))
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        
                        VStack( spacing: 10 ) {
                            Text( NSLocalizedString("lookUpBirthday", comment: ""))
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Gilroy-Bold", size: 18))
                                .lineLimit(1)
                            
                            Text( NSLocalizedString("birthdayYouCanLook", comment: ""))
                                .foregroundColor(.white)
                                .font(.custom("Gilroy-Regular", size: 14))
                                .multilineTextAlignment(.center)
                                .lineLimit(8)
                        }.fixedSize(horizontal: false, vertical: true)
                    }.padding()
                    
                    VStack( alignment: .leading, spacing: 10) {
                        Text( NSLocalizedString("birthday", comment: "") )
                            .foregroundColor(.gray)
                            .font(.custom("Gilroy-Regular", size: 14))
                            .lineLimit(1)
                        
                        
                        HStack {
                            
                            Button(action: {
                                fullscreen.toggle()
                            }, label: {
                                
                                Text( reportVM.returnDate(month: reportVM.birthdayMonth,
                                                          day: reportVM.birthday,
                                                          year: reportVM.birthdayYear))
                                    .foregroundColor(.white)
                                    .font(.custom("times", size: 20))
                                    .frame( width: .greedy, height: 50 )
                                
                            }).fullScreenCover(isPresented: $fullscreen) {
                                ReportBirthdayPicker(month: $reportVM.birthdayMonth, day: $reportVM.birthday, year: $reportVM.birthdayYear)
                            }
                            
                            Button {
                                birthdayOrRelationship = false
                                reportVM.getBirthdayReport()
                            } label: {
                                Text( NSLocalizedString("showBirthdayReport", comment: ""))
                                    .frame( width: .greedy, height: 50 )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 16))
                                    .background(AppColors.accentColor)
                                    .cornerRadius(25)
                            }
                            
                        }.background(RoundedRectangle(cornerRadius: 25)
                                        .fill(AppColors.birthdayBoxBG))
                        
                        Divider()
                        
                    }.padding([.leading, .trailing])
                    
                    VStack ( spacing: 10 ) {
                        
                        VStack( spacing: 10 ) {
                            Text( NSLocalizedString("lookUpRelationship", comment: ""))
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Gilroy-Bold", size: 18))
                                .lineLimit(1)
                            
                            Text( NSLocalizedString("relationshipYouCanLook", comment: ""))
                                .foregroundColor(.white)
                                .font(.custom("Gilroy-Regular", size: 15))
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                                .lineLimit(nil)
                        }.fixedSize(horizontal: false, vertical: true)
                        
                        VStack( alignment: .leading, spacing: 10) {
                            
                            HStack {
                                Button(action: {
                                    showFullscreenReportOne.toggle()
                                }, label: {
                                    
                                    VStack( alignment: .leading, spacing: 10) {
                                        
                                        Text( NSLocalizedString("day", comment: "") )
                                            .foregroundColor(.gray)
                                            .font(.custom("Gilroy-Regular", size: 10))
                                        
                                        
                                        Text( reportVM.returnDate(month: reportVM.firstReportMonth,
                                                                  day: reportVM.firstReportDay,
                                                                  year: reportVM.firstReportYear) )
                                            .foregroundColor(.white)
                                            .font(.custom("times", size: 20))
                                    }.frame(width: .greedy)
                                    
                                }).fullScreenCover(isPresented: $showFullscreenReportOne) {
                                    ReportBirthdayPicker(month: $reportVM.firstReportMonth, day: $reportVM.firstReportDay, year: $reportVM.firstReportYear)
                                }
                                
                                Divider()
                                    .frame(height: 40)
                                
                                Button(action: {
                                    showFullscreenReportTwo.toggle()
                                }, label: {
                                    VStack( alignment: .leading, spacing: 10) {
                                        
                                        Text( NSLocalizedString("day", comment: "") )
                                            .foregroundColor(.gray)
                                            .font(.custom("Gilroy-Regular", size: 10))
                                        Text(reportVM.returnDate(month: reportVM.secondReportMonth,
                                                                 day: reportVM.secondReportDay,
                                                                 year: reportVM.secondReportYear))
                                            .foregroundColor(.white)
                                            .font(.custom("times", size: 20))
                                        
                                    }.frame(width: .greedy)
                                    
                                }).fullScreenCover(isPresented: $showFullscreenReportTwo) {
                                    ReportBirthdayPicker(month: $reportVM.secondReportMonth, day: $reportVM.secondReportDay, year: $reportVM.secondReportYear)
                                }
                            }
                            
                            Divider()
                                .padding(.bottom)
                            
                            Button {
                                birthdayOrRelationship = true
                                reportVM.getRelationshipReport()
                            } label: {
                                Text( NSLocalizedString("showRelationshipReport", comment: ""))
                                    .frame( width: .greedy, height: 50 )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 16))
                                    .background(AppColors.accentColor)
                                    .cornerRadius(25)
                            }
                        }
                        
                        AllRightsReservedMadeByDoejo()
                            .fixedSize(horizontal: false, vertical: true)

                    }.padding()
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    

                }.padding(.top, 1)
                
                CustomAlert(isPresented: $reportVM.showAlert, alertMessage: reportVM.alertMessage, alignment: .center)
                    .offset(y: reportVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: "Reports"), displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "reloadReport"))) { _ in
            if birthdayOrRelationship {
                reportVM.getRelationshipReport()
            } else {
                reportVM.getBirthdayReport()
            }
        }
    }
}

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
