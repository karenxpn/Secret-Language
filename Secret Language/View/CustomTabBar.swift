//
//  CustomTabBar.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var currentTab: Int
    @State private var tab: Bool = true
    let icons = ["starIcon", "birthdayIcon", "searchIcon", "chatIcon", "profileIcon"]
    
    var body: some View {
        Group {
            if tab {
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 50, style: .continuous)
                        .fill(AppColors.tabBg)
                        .opacity(0.8)
                    
                    HStack {
                        
                        ForEach ( 0..<icons.count ) { id in
                            
                            Spacer()
                            Image(icons[id])
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .foregroundColor(id == currentTab ? .accentColor : .white)
                                .frame(width: 20, height: 20)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 6)
                                .onTapGesture {
                                    withAnimation {
                                        currentTab = id
                                    }
                                }
                            Spacer()
                        }
                        
                    }.frame(minWidth: 0, maxWidth: .infinity)
                    .padding(10)
                }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 1)
                .padding()
                .padding(.bottom, 30)
            } else {
                EmptyView()
            }
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "hideTabBar"))) { _ in
            tab = false
        }.onReceive(NotificationCenter.default.publisher(for: Notification.Name(rawValue: "showTabBar"))) { _ in
            withAnimation {
                tab = true
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(currentTab: .constant( 0 ))
    }
}
