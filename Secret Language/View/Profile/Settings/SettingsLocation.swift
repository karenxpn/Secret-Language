//
//  SettingsLocation.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 30.09.21.
//

import SwiftUI
import MapKit

struct SettingsLocation: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    @State private var selectedLocation: Int?
    
    var body: some View {
        ZStack( alignment: .bottomTrailing) {
            Background()
            
            ScrollView( showsIndicators: false ) {
                LazyVStack {
                                        
                    TextField("Chicago, USA", text: $settingsVM.locationText)
                        .font(.custom("times", size: 20))
                        .foregroundColor(.white)
                        .padding([.top, .horizontal])
                    
                    Divider()
                    
                    if settingsVM.loadingLocations {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    }
                    
                    ForEach( settingsVM.locations, id: \.id ) { location in
                        Button {
                            withAnimation {
                                self.selectedLocation = location.id
                            }
                        } label: {
                            
                            VStack {
                                HStack {
                                    Text( location.name )
                                        .foregroundColor(Color.white)
                                        .font(.custom("Aveir", size: 18))
                                    
                                    Spacer()
                                    
                                    if location.id == selectedLocation {
                                        Image(systemName: "checkmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .foregroundColor(Color.white)
                                            .frame( width: 18, height: 18)
                                    }
                                }
                                Divider()
                            }
                            .padding([.top, .horizontal])
                        }
                    }
                }.padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
            }.padding(.top, 1)

                
                Button(action: {
                    // do action here
                    if let location = selectedLocation {
                        settingsVM.updateLocation(id: location)
                    }
                }, label: {
                    Image("proceed")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50, height: 50)
                }).padding()
            .padding(.bottom, UIScreen.main.bounds.size.height * 0.1)
            
        }.gesture(DragGesture().onChanged({ _ in
            UIApplication.shared.endEditing()
        }))
    }
}

struct SettingsLocation_Previews: PreviewProvider {
    static var previews: some View {
        SettingsLocation()
            .environmentObject(SettingsViewModel())
    }
}
