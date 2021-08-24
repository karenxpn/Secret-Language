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
    @StateObject var locationManager = LocationManager()
    @State private var locationChanged: Bool = false
    @AppStorage( "showMatchIntroduction" ) private var showMatchIntroduction = true

    var location: Location {
        return Location(lat: locationManager.lastLocation?.coordinate.latitude ?? 0,
                        lng: locationManager.lastLocation?.coordinate.longitude ?? 0)
    }
    
    @State var userLocation: Location?
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if matchesVM.loadingMatches {
                    ProgressView()
                } else {
                    ZStack {
                        
                        if matchesVM.matches.isEmpty && !matchesVM.loadingMatches{
                            Text( NSLocalizedString("congratsOnLookingThroughEveryone", comment: ""))
                                .foregroundColor(.white)
                                .font(.custom("Avenir", size: 18))
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
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
                
                if showMatchIntroduction {
                    MatchesIntroduction()
                }
                
            }.edgesIgnoringSafeArea(.bottom)
            .onAppear(perform: {
                matchesVM.getMatches()
            }).onChange(of: location, perform: { _ in
                if !locationChanged {
                    locationChanged = true
                    matchesVM.sendLocation(location: location)
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
