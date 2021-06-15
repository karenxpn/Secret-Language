//
//  Matches.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Matches: View {
    
    @State private var showFilter: Bool = false
    @ObservedObject var matchesVM = MatchesViewModel()
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()

                if matchesVM.loadingMatches {
                    ProgressView()
                } else {
                    ZStack {
                        
                        Text( NSLocalizedString("congratsOnLookingThroughEveryone", comment: ""))
                            .foregroundColor(.white)
                            .font(.custom("Avenir", size: 18))
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        ForEach( matchesVM.matches ) { match in
                            SingleMatch(match: match)
                                .padding(.horizontal, 8)
                        }
                    }
                }
                                
                CustomAlert(isPresented: $matchesVM.showAlert, alertMessage: matchesVM.alertMessage, alignment: .center)
                    .offset(y: matchesVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))

            }.edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                matchesVM.getMatches()
            })
            .navigationBarTitle( "" )
            .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("matches", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showFilter.toggle()
            }, label: {
                Image( "filterIcon" )
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
            }))
            .fullScreenCover(isPresented: $showFilter, content: {
                FilterMatches()
                    .environmentObject(matchesVM)
            })
        }
        
    }
}

struct Matches_Previews: PreviewProvider {
    static var previews: some View {
        Matches()
    }
}
