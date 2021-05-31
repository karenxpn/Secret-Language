//
//  Introduction.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 31.05.21.
//

import SwiftUI

struct Introduction: View {
    var body: some View {
        
        NavigationView {
            
            ZStack {
                Background()
                
                VStack {
                    Image( "intro" )
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.main.bounds.size.width * 0.8, height: UIScreen.main.bounds.size.height * 0.5)
                    
                    Text( "Secret Language" )
                        .foregroundColor(.white)
                        .font(.custom("times", size: 25))
                    
                    Text( NSLocalizedString("introMeeting", comment: "") )
                        .foregroundColor(.gray)
                        .font(.custom("times", size: 12))
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    
                    HStack {
                        
                        Spacer()
                        Text( NSLocalizedString("introRomance", comment: "") )
                            .foregroundColor(.accentColor)
                            .font(.custom("times", size: 14))
                        
                        Spacer()
                        
                        Text( NSLocalizedString("introFriendship", comment: "") )
                            .foregroundColor(.accentColor)
                            .font(.custom("times", size: 14))
                        
                        Spacer()
                        
                        Text( NSLocalizedString("introBusiness", comment: "") )
                            .foregroundColor(.accentColor)
                            .font(.custom("times", size: 14))
                        Spacer()
                    }
                    
                    NavigationLink( destination: SignUp(), label: {
                        Text(NSLocalizedString("next", comment: ""))
                            .foregroundColor(.black)
                            .font(.custom("times", size: 16))
                            .frame(width: UIScreen.main.bounds.size.width * 0.7)
                            .padding()
                            .background(Color.accentColor)
                            .cornerRadius(25)
                            .padding()
                    })
                }
            }.navigationBarHidden(true)
        }
    }
}

struct Introduction_Previews: PreviewProvider {
    static var previews: some View {
        Introduction()
    }
}
