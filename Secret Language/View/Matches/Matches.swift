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
    @ObservedObject var locationManager = LocationManager()
    
    @State var userLocation: Location?
    
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
                                .environmentObject( matchesVM )
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
                
                userLocation = Location(lat: locationManager.lastLocation?.coordinate.latitude ?? 0.0,
                                        lng: locationManager.lastLocation?.coordinate.longitude ?? 0.0)

                if userLocation != nil {
                    matchesVM.sendLocation(location: userLocation!)
                }
            })
            .navigationBarTitle( "" )
            .navigationBarTitleView(MatchesNavBar(title: NSLocalizedString("matches", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                showFilter.toggle()
            }, label: {
                Image( "filterIcon" )
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding([.leading, .top, .bottom])
            }))
            .fullScreenCover(isPresented: $showFilter, onDismiss: {
                print( "Dismissed" )
                matchesVM.getMatches()
                // reload searched on dismiss
            }, content: {
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
