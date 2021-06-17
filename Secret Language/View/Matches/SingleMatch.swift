//
//  SingleMatch.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleMatch: View {
    
    @State var match: MatchViewModel
    var body: some View {
        
        ZStack ( alignment: .top, content: {
            ScrollView( showsIndicators: false ) {
                
                WebImage(url: URL(string: match.image))
                    .placeholder(content: {
                        ProgressView()
                    })
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width - 24,
                           height: UIScreen.main.bounds.size.height * 0.7)
                    .clipped()
                    .cornerRadius(15)
                    .padding(.vertical)

                Text( "\(match.name), \(match.age)" )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 20))
                
                HStack( spacing: 0) {
                    Text( NSLocalizedString("idealFor", comment: ""))
                        .foregroundColor(.gray)
                        .font(.custom("avenir", size: 14))
                    
                    Text(match.ideal)
                        .foregroundColor(.accentColor)
                        .font(.custom("avenir", size: 14))
                }
                
                Text( "..." )
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.bottom, 8)
                
                // birthdays, etc
                
                HStack {
                    VStack( alignment: .leading) {
                        Text( match.myBirthday )
                            .font(.custom("times", size: 16))
                            .foregroundColor(.white)
                        
                        HStack( spacing: 0) {
                            Text( NSLocalizedString("weekOf", comment: ""))
                                .foregroundColor(.gray)
                                .font(.custom("Avenir", size: 12))
                            
                            Text( match.myBirthdayWeek )
                                .foregroundColor(.accentColor)
                                .font(.custom("Avenir", size: 12))
                        }
                    }
                    
                    Spacer()
                    
                    VStack( alignment: .trailing) {
                        Text( match.partnerBirthday )
                            .font(.custom("times", size: 16))
                            .foregroundColor(.white)
                        
                        HStack( spacing: 0) {
                            Text( NSLocalizedString("weekOf", comment: ""))
                                .foregroundColor(.gray)
                                .font(.custom("Avenir", size: 12))
                            
                            Text( match.partnerBirthdayWeek )
                                .foregroundColor(.accentColor)
                                .font(.custom("Avenir", size: 12))
                        }
                    }
                }.padding(.horizontal)
                
                Image("phoneNumberimg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    
                
                VStack {
                    Text( match.title )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 24))
                        .fontWeight(.bold)
                        .padding(8)
                    
                    Text( match.sln_description)
                        .foregroundColor(.accentColor)
                        .font(.custom("times-italic", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(8)
                    
                    Text( "\(NSLocalizedString("since1701", comment: "")) \(match.famous_years)")
                        .foregroundColor(.white)
                        .font(.custom("times", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(8)
                    
                    Text( NSLocalizedString("relationshipPersonality", comment: ""))
                        .font(.custom("times", size: 18))
                        .foregroundColor(.accentColor)
                    
                    LabelAlignment(text: match.report, textAlignmentStyle: .justified, width: UIScreen.main.bounds.width - 30)
                    
                    
                    Text( NSLocalizedString("advice", comment: ""))
                        .font(.custom("times", size: 18))
                        .foregroundColor(.accentColor)
                    
                    Text( match.advice )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(8)
                }
                
                Divider()
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                
            }.padding(.top, 1)

            // yea and no actions
            
            Image( "leftSwipeIcon" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame( width: 50, height: 50)
                .padding()
                .opacity(Double(match.x/10 * -1 - 1))

            Image( "rightSwipeIcon" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame( width: 50, height: 50)
                .padding()
                .opacity(Double(match.x/10 - 1))
            
        }).background(Background())
        .cornerRadius(15)
        .offset(x: match.x)
        .rotationEffect(.init(degrees: match.degree))
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.default) {
                        if value.translation.width > 50 ||
                            value.translation.width < -50 {
                            match.x = value.translation.width
                            match.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                        } else {
                            match.x = 0
                            match.degree = 0
                        }
                    }
                })
                .onEnded({ value in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                            case 0...100:
                                match.x = 0; match.degree = 0;
                            case let x where x > 100:
                                match.x = 500; match.degree = 12
                            case (-100)...(-1):
                                match.x = 0; match.degree = 0;
                            case let x where x < -100:
                                match.x  = -500; match.degree = -12
                            default:
                                match.x = 0;
                        }
                    }
                })
        )
    }
}

struct SingleMatch_Previews: PreviewProvider {
    static var previews: some View {
        SingleMatch(match: MatchViewModel(match: MatchModel(id: 1, username: "username", name: "John Smith", age: 26, sln: "Solved Blissful Wizard", sln_description: "This name describes the life energy of this day. People born during this day will ratain and radiate its energy and will exhibit most of the personality traits we discovered for their day, week, month, season and year as shown below", report: "This relationship can explore the far reaches of thought and fantasy, but will also ground itself in the here and now. The metaphor of dance suggests itself—leaping, literally flying, then returning to the ground to gather energy. The relationship usually shows enough sense to build itself around a practical endeavor in which both partners feel fulfilled in their work. Without this basis, they are likely to drift, or sometimes to try to escape from the demands of daily life altogether. The relationship has an air of unreality.\\r\\nCusp of Energy people can be swept away by the combination’s fancifulness. They are on the flighty side to begin with, and the illusions spun here may be too much for them. Week of Determination individuals, on the other hand, always serious and usually laden with responsibilities, will initially be liberated by the matchup’s imaginativeness, but may later try to exert control. Cusp of Energy persons will bear the brunt of the relationship’s amorphousness.\\r\\nCharming and piquant, as a love affair the relationship is at first blush the very essence of romance. Yet it is eventually likely to be secretive and to exhibit neurotic symptoms of anxiety and worry. Marriage is usually more favorable: domestic tasks, financial planning and building a family can be the grounding influences the relationship requires. The best bet of all is probably friendship, which will feature a never-ending stream of ideas for things to do, both intellectual and physical. Such friends may well travel, exercise and work together. Good feelings, affection and gift-giving are characteristic here.\\r\\nSiblings in this combination will seem as different as night and day, but their personalities can dovetail well. The dangers here are overdependence and a lack of individual development. Differences of temperament in parent-child combinations (Week of Determination people serious and demanding, Cusp of Energy persons fun-loving and flexible) may establish a contentious but rarely boring family dynamic. Since the relationship does well grounding itself in daily activities, career matchups are favored. These two can work side by side for years and still maintain their individuality. They will constitute an effective unit for getting the job done efficiently and dependably.", advice: "Keep in touch with daily demands.\\r\\nBe responsible but don’t forget to dream.\\r\\nMaster fear and anxiety.\\r\\nDon’t suppress affection.", ideal_for: "friendship", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", famous_years: "1702 1758 1814 1851 1907 1944 2000", my_birthday: "December 26, 1993", my_birthday_name: "Ruler", user_birthday: "January 23, 1983", user_birthday_name: "Ruler")))
    }
}
