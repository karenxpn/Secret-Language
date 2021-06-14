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
        ScrollView {
            
            ZStack ( alignment: .top, content: {
                VStack {
                    Image(systemName: card.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .padding(.bottom)
                    
                    Text( card.name )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 20))
                    
                    HStack {
                        Text( NSLocalizedString("idealFor", comment: ""))
                            .foregroundColor(.gray)
                            .font(.custom("avenir", size: 14))
                        
                        ForEach( card.ideal, id: \.self ) { ideal in
                            Text(ideal)
                                .foregroundColor(.accentColor)
                                .font(.custom("avenir", size: 14))
                        }
                    }
                }
                
                // yea and no actions
                Text( "YES" )
                    .frame(width: 150)
                    .opacity(Double(card.x/10 - 1))

                Text( "NO" )
                    .opacity(Double(card.x/10 * -1 - 1))
                
            }).padding()
            .cornerRadius(30)
        }.offset(x: card.x, y: card.y)
        .rotationEffect(.init(degrees: card.degree))
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.default) {
                        card.x = value.translation.width
                        // MARK: - BUG 5
                        card.y = value.translation.height
                        card.degree = 7 * (value.translation.width > 0 ? 1 : -1)
                    }
                })
                .onEnded({ value in
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 8, initialVelocity: 0)) {
                        switch value.translation.width {
                        case 0...100:
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x > 100:
                            card.x = 500; card.degree = 12
                        case (-100)...(-1):
                            card.x = 0; card.degree = 0; card.y = 0
                        case let x where x < -100:
                            card.x  = -500; card.degree = -12
                        default:
                            card.x = 0; card.y = 0
                        }
                    }
                })
        )
    }
}

struct SingleMatch_Previews: PreviewProvider {
    static var previews: some View {
        SingleMatch(card: CardViewModel(card: Card(name: "Rosie", imageName: "pencil", age: 21, bio: "Insta - roooox 💋", ideal: ["Family", "Romance"])))
    }
}
