//
//  SingleMatch.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SingleMatch: View {
    
    @EnvironmentObject var matchesVM: MatchesViewModel
    @State var match: MatchViewModel
    @State private var blure: CGFloat = 0
    
    var body: some View {
        
        ZStack ( alignment: .center, content: {
            ScrollView( showsIndicators: false ) {
                
                TapImagesCarousel(images: match.images, x: $match.x)
                    .blur(radius: blure)
                
                Text( "\(match.name), \(match.age)" )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 20))
                
                HStack( spacing: 0) {
                    Text( NSLocalizedString("idealFor", comment: ""))
                        .foregroundColor(.gray)
                        .font(.custom("avenir", size: 14))
                    
                    Text(match.ideal)
                        .foregroundColor(AppColors.accentColor)
                        .font(.custom("avenir", size: 14))
                }
                
                Text( match.distance )
                    .font(.custom("times", size: 14))
                    .foregroundColor(.white)
                
                Text( match.lookingFor)
                    .foregroundColor(AppColors.accentColor)
                    .font(.custom("avenir", size: 14))
                
                Text( "..." )
                    .foregroundColor(.white)
                    .font(.title2)
                    .padding(.bottom, 8)
                
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
                                .foregroundColor(AppColors.accentColor)
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
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Avenir", size: 12))
                        }
                    }
                }.padding(.horizontal)
                
                ImageHelper(image: match.illustration, contentMode: .fit, progressViewTintColor: .black)
                    .frame(width: 130, height: 130)
                    .padding()
                    .background(.white)
                    .clipShape(Circle())
                
                VStack {
                    Text( match.title )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 24))
                        .fontWeight(.bold)
                        .padding(8)
                    
                    Text( match.sln_description)
                        .foregroundColor(AppColors.accentColor)
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
                        .foregroundColor(AppColors.accentColor)

                    Text( match.report )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 16))
                        .padding(.horizontal, 10)
                    
                    
                    Text( NSLocalizedString("advice", comment: ""))
                        .font(.custom("times", size: 18))
                        .foregroundColor(AppColors.accentColor)

                    Text( match.advice )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 16))
                        .multilineTextAlignment(.center)
                        .padding(8)
                }.fixedSize(horizontal: false, vertical: true)
                
                AllRightsReservedMadeByDoejo()
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                
            }.padding(.top, 1)
            
            // yea and no actions
            
            Image( "leftSwipeIcon" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame( width: 50, height: 50)
                .padding()
                .opacity(match.x < -50 ? 1 : 0)
            
            VStack {
                Image( "rightSwipeIcon" )
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame( width: 50, height: 50)
                
                Text( NSLocalizedString("idealFor", comment: ""))
                    .foregroundColor(.white)
                    .font(.custom("avenir", size: 17))
                    .fontWeight(.semibold)
                
                Text(match.ideal)
                    .foregroundColor(AppColors.accentColor)
                    .font(.custom("avenir", size: 17))
                    .fontWeight(.semibold)
                
            }.padding()
                .opacity(match.x > 50 ? 10 : 0)

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
                            blure += 0.4
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
                            match.x = 0
                            match.degree = 0
                            blure = 0
                        case let x where x > 100:
                            if match.id == matchesVM.matches.first?.id {
                                matchesVM.matchPage += 1
                                matchesVM.getMatches()
                            }
                            match.x = 500; match.degree = 12
                            matchesVM.sendFriendRequest(matchID: match.id)
                        case (-100)...(-1):
                            match.x = 0
                            match.degree = 0
                            blure = 0
                        case let x where x < -100:
                            if match.id == matchesVM.matches.first?.id {
                                matchesVM.matchPage += 1
                                matchesVM.getMatches()
                            }
                            match.x  = -500; match.degree = -12
                            matchesVM.removeMatch(matchID: match.id)
                        default:
                            match.x = 0;
                            blure = 0
                        }
                    }
                })
        )
    }
}

struct SingleMatch_Previews: PreviewProvider {
    static var previews: some View {
        SingleMatch(match: PreviewParameters.match)
    }
}
