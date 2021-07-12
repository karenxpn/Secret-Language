//
//  RelationshipReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 05.07.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct RelationshipReport: View {
    @Binding var report: RelationshipReportModel?
    
    var body: some View {
        ZStack {
            Background()
            
            if report != nil {
                ScrollView( showsIndicators: false ) {
                    
                    VStack {
                        
                        HStack {
                            
                            VStack {
                                Text( report!.birthday_1 )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 20))
                                    .fontWeight(.heavy)
                                
                                Text( report!.birthday_1_name )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 16))
                            }
                            
                            Spacer()
                            
                            Text( "&" )
                                .foregroundColor(.black)
                                .font(.custom("times", size: 28))
                            
                            Spacer()
                            
                            VStack {
                                Text( report!.birthday_2 )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 20))
                                    .fontWeight(.heavy)
                                
                                Text( report!.birthday_2_name )
                                    .foregroundColor(.black)
                                    .font(.custom("times", size: 16))
                            }
                        }
                        
                        Text( "IS CALLED" )
                            .foregroundColor(.black)
                            .font(.custom("Avenir", size: 14))
                        
                        WebImage(url: URL(string: report!.image ))
                            .placeholder {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                            }.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: .greedy, height: 150)
                            .padding()
                        
                        Text( report!.name )
                            .foregroundColor(.black)
                            .font(.custom("times", size: 22))
                            .fontWeight(.heavy)
                        
                        SWViewHelper(s1: report!.s1, s2: report!.s2, s3: report!.s3,
                                     w1: report!.w1, w2: report!.w2, w3: report!.w3)
                        
                        HStack( spacing: 0) {
                            Text( NSLocalizedString("idealFor", comment: ""))
                                .foregroundColor(.black)
                                .font(.custom("avenir", size: 14))
                            
                            Text(report!.ideal_for)
                                .foregroundColor(.accentColor)
                                .font(.custom("avenir", size: 14))
                        }
                        
                        HStack( spacing: 0) {
                            Text( NSLocalizedString("problematic", comment: ""))
                                .foregroundColor(.black)
                                .font(.custom("avenir", size: 14))
                            
                            Text(report!.problematic_for)
                                .foregroundColor(.accentColor)
                                .font(.custom("avenir", size: 14))
                        }
                        
                    }.padding()
                    .background(.white)
                    
                    VStack( spacing: 10 ) {
                        
                        Text( NSLocalizedString("relationshipPersonality", comment: ""))
                            .font(.custom("times", size: 18))
                            .foregroundColor(.accentColor)
                        
                        LabelAlignment(text: report!.report, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
                        
                        Text( NSLocalizedString("advice", comment: ""))
                            .font(.custom("times", size: 18))
                            .foregroundColor(.accentColor)
                        
                        Text( report!.advice )
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
    }
}

struct RelationshipReport_Previews: PreviewProvider {
    static var previews: some View {
        RelationshipReport(report: .constant( PreviewParameters.relationshipReport ) )
    }
}
