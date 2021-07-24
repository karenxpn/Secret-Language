//
//  SharedRelationshipReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SharedRelationshipReport: View {
    
    @ObservedObject var reportVM = ReportViewModel()
    @Environment(\.presentationMode) var presentationMode
    let reportID: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if reportVM.loading {
                    ProgressView()
                } else if reportVM.relationshipReport != nil {
                    
                    ScrollView( showsIndicators: false ) {
                        
                        VStack {
                            
                            HStack {
                                
                                VStack {
                                    Text( reportVM.relationshipReport!.birthday_1 )
                                        .foregroundColor(.black)
                                        .font(.custom("times", size: 20))
                                        .fontWeight(.heavy)
                                    
                                    Text( reportVM.relationshipReport!.birthday_1_name )
                                        .foregroundColor(.black)
                                        .font(.custom("times", size: 16))
                                }
                                
                                Spacer()
                                
                                Text( "&" )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 28))
                                
                                Spacer()
                                
                                VStack {
                                    Text( reportVM.relationshipReport!.birthday_2 )
                                        .foregroundColor(.black)
                                        .font(.custom("times", size: 20))
                                        .fontWeight(.heavy)
                                    
                                    Text( reportVM.relationshipReport!.birthday_2_name )
                                        .foregroundColor(.black)
                                        .font(.custom("times", size: 16))
                                }
                            }
                            
                            Text( "IS CALLED" )
                                .foregroundColor(.black)
                                .font(.custom("Avenir", size: 14))
                            
                            WebImage(url: URL(string: reportVM.relationshipReport!.image ))
                                .placeholder {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                                }.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: .greedy, height: 150)
                                .padding()
                            
                            Text( reportVM.relationshipReport!.name )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 22))
                                .fontWeight(.heavy)
                            
                            SWViewHelper(s1: reportVM.relationshipReport!.s1, s2: reportVM.relationshipReport!.s2, s3: reportVM.relationshipReport!.s3,
                                         w1: reportVM.relationshipReport!.w1, w2: reportVM.relationshipReport!.w2, w3: reportVM.relationshipReport!.w3)
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("idealFor", comment: ""))
                                    .foregroundColor(.black)
                                    .font(.custom("avenir", size: 14))
                                
                                Text(reportVM.relationshipReport!.ideal_for)
                                    .foregroundColor(.accentColor)
                                    .font(.custom("avenir", size: 14))
                            }
                            
                            HStack( spacing: 0) {
                                Text( NSLocalizedString("problematic", comment: ""))
                                    .foregroundColor(.black)
                                    .font(.custom("avenir", size: 14))
                                
                                Text(reportVM.relationshipReport!.problematic_for)
                                    .foregroundColor(.accentColor)
                                    .font(.custom("avenir", size: 14))
                            }
                            
                        }.padding()
                        .background(.white)
                        
                        VStack( spacing: 10 ) {
                            
                            Text( NSLocalizedString("relationshipPersonality", comment: ""))
                                .font(.custom("times", size: 18))
                                .foregroundColor(.accentColor)
                            
                            LabelAlignment(text: reportVM.relationshipReport!.report, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
                            
                            Text( NSLocalizedString("advice", comment: ""))
                                .font(.custom("times", size: 18))
                                .foregroundColor(.accentColor)
                            
                            Text( reportVM.relationshipReport!.advice )
                                .foregroundColor(.white)
                                .font(.custom("times", size: 16))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                            
                        }.padding(.top)
                        .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                        
                    }.padding(.top, 1)
                }
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("relationshipBetween", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
            })).onAppear {
                reportVM.getSharedRelationshipReport(reportID: reportID)
            }
        }
        
    }
}

struct SharedRelationshipReport_Previews: PreviewProvider {
    static var previews: some View {
        SharedRelationshipReport(reportID: 1)
    }
}
