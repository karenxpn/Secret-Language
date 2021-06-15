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

                Text( match.name )
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
                    
                    Text( match.content)
                        .foregroundColor(.accentColor)
                        .font(.custom("times-italic", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(8)
                    
                    Text( "\(NSLocalizedString("advice", comment: "")) \(match.advice)" )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 18))
                        .multilineTextAlignment(.center)
                        .padding(8)
                    
                    
                    Text( "\(NSLocalizedString("problematic", comment: "")) \(match.problematic)" )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 18))
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
        SingleMatch(match: MatchViewModel(match: MatchModel(id: 1, title: "Solved Blissful Wizard", s1: "relaxed", s2: "social", s3: "asdf", w1: "relaxed", w2: "social", w3: "asdf", report: "report", advice: "Since 1701, this very rare name has only been given the poeple born on this day in these years: 1737 1774 1830 1867 1923 1979 2916", ideal: "Business", problematic: "for love", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", name: "Name Surname", content: "``This name describes the life energy of this day. People born during this day will ratain and radiate its energy and will exhibit most of the personality traits we discovered for their day, week, month, season and year as shown below``", my_birthday: "December 26, 1993", my_birthday_name: "Ruler", user_birthday: "January 23, 1983", user_birthday_name: "Ruler")))
    }
}
