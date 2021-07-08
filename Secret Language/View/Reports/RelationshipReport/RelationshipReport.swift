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
        RelationshipReport(report: .constant( RelationshipReportModel(id: 1, birthday_1: "19 January", birthday_1_name: "Week of Love", birthday_2: "20 January", birthday_2_name: "Week of friendship", image: "https://sln-storage.s3.us-east-2.amazonaws.com/img/icon/rel/150/png/0066.png", name: "Creature comforts", s1: "Aesthetic", s2: "Cultiral", s3: "Secure", w1: "Aesthetic", w2: "Cultural", w3: "Secure", ideal_for: "Family", report: "his relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", problematic_for: "Friendship")) )
    }
}
