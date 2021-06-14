//
//  SingleMatch.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 14.06.21.
//

import SwiftUI

struct SingleMatch: View {
    
    @State var card: CardViewModel
    var body: some View {
        
        ZStack ( alignment: .top, content: {
            ScrollView( showsIndicators: false ) {
                Image(card.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height * 0.7)
                    .clipped()
                    .cornerRadius(15)
                    .padding(.bottom)
                
                Text( card.name )
                    .foregroundColor(.white)
                    .font(.custom("times", size: 20))
                
                HStack( spacing: 0) {
                    Text( NSLocalizedString("idealFor", comment: ""))
                        .foregroundColor(.gray)
                        .font(.custom("avenir", size: 14))
                    
                    ForEach( 0..<card.ideal.count ) { index in
                        Text("\(index == card.ideal.count - 1 ? "\(card.ideal[index])." : "\(card.ideal[index]), ")")
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
                .opacity(Double(card.x/10 * -1 - 1))

            Image( "rightSwipeIcon" )
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame( width: 50, height: 50)
                .padding()
                .opacity(Double(card.x/10 - 1))
            
        }).background(Background())
        .cornerRadius(15)
        .offset(x: card.x)
        .rotationEffect(.init(degrees: card.degree))
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.default) {
                        if value.translation.width > 50 || value.translation.width < -50 {
                            card.x = value.translation.width
                            card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                        }
                    }
                })
                .onEnded({ value in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                            case 0...100:
                                card.x = 0; card.degree = 0;
                            case let x where x > 100:
                                card.x = 500; card.degree = 12
                            case (-100)...(-1):
                                card.x = 0; card.degree = 0;
                            case let x where x < -100:
                                card.x  = -500; card.degree = -12
                            default:
                                card.x = 0;
                        }
                    }
                })
        )
    }
}

struct SingleMatch_Previews: PreviewProvider {
    static var previews: some View {
        SingleMatch(card: CardViewModel(card: Card(name: "Rosie", imageName: "testImage", age: 21, bio: "Insta - roooox 💋", ideal: ["Family", "Romance"])))
    }
}
