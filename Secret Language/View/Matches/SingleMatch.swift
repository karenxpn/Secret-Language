//
//  SingleMatch.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import SwiftUI

struct SingleMatch: View {
    
    @State var match: MatchViewModel
    var body: some View {
        
        ZStack ( alignment: .top, content: {
            ScrollView( showsIndicators: false ) {
                Image(match.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width - 24, height: UIScreen.main.bounds.size.height * 0.7)
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
                    
                    ForEach( 0..<match.ideal.count ) { index in
                        Text("\(index == match.ideal.count - 1 ? "\(match.ideal[index])." : "\(match.ideal[index]), ")")
                            .foregroundColor(.accentColor)
                            .font(.custom("avenir", size: 14))
                    }
                }
                
                Text( "..." )
                    .foregroundColor(.white)
                    .font(.title2)
                
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
                        if value.translation.width > 50 || value.translation.width < -50 {
                            match.x = value.translation.width
                            match.degree = 7 * (value.translation.width > 0 ? 1 : -1)
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
        SingleMatch(match: MatchViewModel(match: MatchModel(name: "Rosie", imageName: "testImage", age: 21, bio: "Insta - roooox 💋", ideal: ["Family", "Romance"])))
    }
}
