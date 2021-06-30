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
    @State private var actionSheet: Bool = false
    
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                ScrollView( showsIndicators: false ) {
                    VStack ( spacing: 10 ){
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
                        
                        
                        Text( NSLocalizedString("lookUpBirthday", comment: ""))
                            .foregroundColor(.accentColor)
                            .font(.custom("Gilroy-Bold", size: 18))
                        
                        Text( NSLocalizedString("birthdayYouCanLook", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 14))
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        
                        // birthday date picker
                        
                        VStack( alignment: .leading, spacing: 10) {
                            Text( NSLocalizedString("birthday", comment: "") )
                                .foregroundColor(.gray)
                                .font(.custom("Gilroy-Regular", size: 14))
                            
                            Button(action: {
                                fullscreen.toggle()
                            }, label: {
                                Text( dateFormatter.string(from: reportVM.birthdayDate))
                                    .foregroundColor(.white)
                                    .font(.custom("times", size: 20))
                            }).fullScreenCover(isPresented: $fullscreen) { 
                                ReportBirthdayPicker(date: $reportVM.birthdayDate)
                            }
                            Divider()
                                .padding(.bottom)
                        }
                        
                        Text( NSLocalizedString("lookUpRelationship", comment: ""))
                            .foregroundColor(.accentColor)
                            .font(.custom("Gilroy-Bold", size: 18))
                        
                        Text( NSLocalizedString("relationshipYouCanLook", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Gilroy-Regular", size: 14))
                            .lineLimit(nil)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                        
                        VStack( alignment: .leading, spacing: 10) {

                            HStack {
                                Button(action: {
                                    showFullscreenReportOne.toggle()
                                }, label: {
                                    Text( dateFormatter.string(from: reportVM.firstReportDate))
                                        .foregroundColor(.white)
                                        .font(.custom("times", size: 20))
                                }).fullScreenCover(isPresented: $showFullscreenReportOne) {
                                    ReportBirthdayPicker(date: $reportVM.firstReportDate)
                                }
                                
                                Spacer()
                                Divider()
                                    .frame(width: 40)
                                Spacer()
                                
                                Button(action: {
                                    showFullscreenReportTwo.toggle()
                                }, label: {
                                    Text( dateFormatter.string(from: reportVM.secondReportDate))
                                        .foregroundColor(.white)
                                        .font(.custom("times", size: 20))
                                }).fullScreenCover(isPresented: $showFullscreenReportTwo) {
                                    ReportBirthdayPicker(date: $reportVM.secondReportDate)
                                }
                            }

                            Divider()
                                .padding(.bottom)
                        }
                        
                        Button {
                            actionSheet.toggle()
                        } label: {
                            Text( NSLocalizedString("relationshipReport", comment: ""))
                                .frame( minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50 )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 16))
                                .background(.accentColor)
                                .cornerRadius(25)
                        }

                    }.padding()
                }.padding(.top, 2)
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: "Reports"), displayMode: .inline)
            .actionSheet(isPresented: $actionSheet) {
                ActionSheet(title: Text("Report"), message: Text("Choose the report to show"), buttons: [
                        .default(Text("Birthday Report")) {  },
                        .default(Text("Relationship Report")) { },
                        .cancel()
                    ])
            }
        }
    }
}

struct Reports_Previews: PreviewProvider {
    static var previews: some View {
        Reports()
    }
}
