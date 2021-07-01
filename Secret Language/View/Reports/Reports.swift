//
//  Reports.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Reports: View {
    @ObservedObject var reportVM = ReportViewModel()
    @State private var fullscreen: Bool = false
    @State private var showFullscreenReportOne: Bool = false
    @State private var showFullscreenReportTwo: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                ScrollView( showsIndicators: false ) {
                    
                    VStack ( spacing: 10 ) {
                        Image( "reports" )
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 140, height: 140)
                        
                        Text( "Gary Goldschneider’s" )
                            .foregroundColor(.white)
                            .font(.custom("SignPainter", size: 22))

                        Text( "Secret Language" )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 22))
                            .padding(.bottom)
                        
                        VStack( spacing: 10 ) {
                            Text( NSLocalizedString("lookUpBirthday", comment: ""))
                                .foregroundColor(.accentColor)
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
                        
                        Button(action: {
                            fullscreen.toggle()
                        }, label: {
                            Text( "\(reportVM.birthdayMonth) \(reportVM.birthday)")
                                .foregroundColor(.white)
                                .font(.custom("times", size: 20))
                        }).fullScreenCover(isPresented: $fullscreen) {
                            ReportBirthdayPicker(month: $reportVM.birthdayMonth, day: $reportVM.birthday)
                        }
                        Divider()
                            .padding(.bottom)
                        
                        Button {

                        } label: {
                            Text( NSLocalizedString("birthdayReport", comment: ""))
                                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50 )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                                .background(.accentColor)
                                .cornerRadius(25)
                        }
                    }.padding([.bottom, .leading, .trailing])
                    
                    VStack ( spacing: 10 ) {
                        
                        VStack( spacing: 10 ) {
                            Text( NSLocalizedString("lookUpRelationship", comment: ""))
                                .foregroundColor(.accentColor)
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
                                    Text( "\(reportVM.firstReportMonth) \(reportVM.firstReportDay)" )
                                        .foregroundColor(.white)
                                        .font(.custom("times", size: 20))
                                }).fullScreenCover(isPresented: $showFullscreenReportOne) {
                                    ReportBirthdayPicker(month: $reportVM.firstReportMonth, day: $reportVM.firstReportDay)
                                }
                                
                                Spacer()
                                Divider()
                                    .frame(width: 40)
                                Spacer()
                                
                                Button(action: {
                                    showFullscreenReportTwo.toggle()
                                }, label: {
                                    Text( "\(reportVM.secondReportMonth) \(reportVM.secondReportDay)")
                                        .foregroundColor(.white)
                                        .font(.custom("times", size: 20))
                                }).fullScreenCover(isPresented: $showFullscreenReportTwo) {
                                    ReportBirthdayPicker(month: $reportVM.secondReportMonth, day: $reportVM.secondReportDay)
                                }
                            }

                            Divider()
                                .padding(.bottom)
                        }
                        
                        Button {
                        } label: {
                            Text( NSLocalizedString("relationshipReport", comment: ""))
                                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50 )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                                .background(.accentColor)
                                .cornerRadius(25)
                        }

                    }.padding()
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                }.padding(.top, 1)
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: "Reports"), displayMode: .inline)
        }
    }
}

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
