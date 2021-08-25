//
//  SettingsProfileImages.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 25.08.21.
//

import SwiftUI

struct SettingsProfileImages: View {
    
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    var body: some View {
        ZStack {
            Background()
            
            if settingsVM.loadingImages {
                ProgressView()
            } else {
                ScrollView {
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                    LazyVGrid(columns: columns, content: {
                        ForEach( 0..<settingsVM.profileImages.count) { index in
                            SettingsProfileSingleImage(image: settingsVM.profileImages[index])
                        }
                    }).padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            settingsVM.updateFields(updatedFrom: "images")
                        }, label: {
                            Image("proceed")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 50, height: 50)
                        })
                    }
                    
                }.padding(.top, 1)
            }
        }
    }
}

struct SettingsProfileImages_Previews: PreviewProvider {
    static var previews: some View {
        SettingsProfileImages()
    }
}
