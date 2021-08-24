//
//  MatchesIntroduction.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI

struct MatchesIntroduction: View {
    
    @AppStorage( "showMatchIntroduction" ) private var showMatchIntroduction = true
    var body: some View {
        GeometryReader { proxy in
            VStack( alignment: .leading, spacing: 10) {
                
                
                HStack {
                    Spacer()
                    
                    Button(action: {
                        showMatchIntroduction = false
                    }, label: {
                        Text( NSLocalizedString("gotIt", comment: "") )
                            .font(.custom("Avenir", size: 20))
                            .fontWeight(.heavy)
                            .foregroundColor(.black)
                    })
                }.offset(y: 70)
                
                Spacer()
                
                HStack {
                    
                    VStack {
                        Image( "swipeLeftIntroduction" )
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(-30))
                        
                        Text( NSLocalizedString("swipeLeftIntro", comment: ""))
                            .font(.custom("Gilroy-Regular", size: 14))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                    Image( "splash-screen" )
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Spacer()
                    

                    VStack {
                        Image( "swipeRightIntroduction" )
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .rotationEffect(.degrees(30))

                        
                        Text( NSLocalizedString("swipeRightIntro", comment: ""))
                            .font(.custom("Gilroy-Regular", size: 14))
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    }
                }
                
                Spacer()
                
            }.padding()
        }.background(Color.gray.opacity( 0.75 ))
        .edgesIgnoringSafeArea(.all)
    }
}

struct MatchesIntroduction_Previews: PreviewProvider {
    static var previews: some View {
        MatchesIntroduction()
    }
}
