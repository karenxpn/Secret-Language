//
//  Matches.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Matches: View {
    
    @ObservedObject var matchesVM = MatchesViewModel()
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if matchesVM.loadingMatches {
                    ProgressView()
                } else {
                    ZStack {
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
            .navigationBarItems(trailing: NavigationLink(
                                    destination: FilterMatches(),
                                    label: {
                                        Image( "filterIcon" )
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: 20, height: 20)
                                    }))
        }
        
    }
}

struct Matches_Previews: PreviewProvider {
    static var previews: some View {
        Matches()
    }
}
