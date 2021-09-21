//
//  FriendRequestCell.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 21.06.21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FriendRequestCell: View {
    
    @EnvironmentObject var profileVM: ProfileViewModel
    let request: UserPreviewModel
    @State private var active: Bool = false
    
    var body: some View {
        
        if #available(iOS 15.0, *) {
            Button {
                active.toggle()
            } label: {
                HStack( spacing: 20) {
                    WebImage(url: URL(string: request.image))
                        .placeholder {
                            ProgressView()
                        }.resizable()
                        .scaledToFill()
                        .frame(width: 55, height: 55)
                        .clipShape(Circle())
                    
                    VStack( alignment: .leading) {
                        Text( request.name )
                            .foregroundColor(.white)
                            .font(.custom("times", size: 18))
                        
                        HStack( spacing: 0) {
                            Text( "\(NSLocalizedString("idealFor", comment: ""))")
                                .foregroundColor(.gray)
                                .font(.custom("Gilroy-Regular", size: 15))
                            
                            Text( request.ideal)
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Gilroy-Regular", size: 15))
                                .lineLimit(1)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        profileVM.acceptFriendRequest(userID: request.id)
                    }, label: {
                        Text(NSLocalizedString("accept", comment: ""))
                            .foregroundColor( AppColors.accentColor )
                            .font(.custom("Gilroy-Regular", size: 14))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 18)
                            .background(RoundedRectangle(cornerRadius: 4)
                                            .strokeBorder(AppColors.accentColor, lineWidth: 1.5)
                                            .background(AppColors.dataFilterGendersBg)
                            )
                    })
                }.padding(.bottom)
            }.background(
                NavigationLink(destination: VisitedProfile(userID: request.id, userName: request.name), isActive: $active) {
                    EmptyView()
                }.hidden()
            )
        } else {
            Button {
              } label: {
                  HStack( spacing: 20) {
                      WebImage(url: URL(string: request.image))
                          .placeholder {
                              ProgressView()
                          }.resizable()
                          .scaledToFill()
                          .frame(width: 55, height: 55)
                          .clipShape(Circle())
                      
                      VStack( alignment: .leading) {
                          Text( request.name )
                              .foregroundColor(.white)
                              .font(.custom("times", size: 18))
                          
                          HStack( spacing: 0) {
                              Text( "\(NSLocalizedString("idealFor", comment: ""))")
                                  .foregroundColor(.gray)
                                  .font(.custom("Gilroy-Regular", size: 15))
                              
                              Text( request.ideal)
                                  .foregroundColor(.accentColor)
                                  .font(.custom("Gilroy-Regular", size: 15))
                                  .lineLimit(1)
                          }
                      }
                      
                      Spacer()
                      
                      Button(action: {
                          profileVM.acceptFriendRequest(userID: request.id)
                      }, label: {
                          Text(NSLocalizedString("accept", comment: ""))
                              .foregroundColor( .accentColor )
                              .font(.custom("Gilroy-Regular", size: 14))
                              .padding(.vertical, 8)
                              .padding(.horizontal, 18)
                              .background(RoundedRectangle(cornerRadius: 4)
                                              .strokeBorder(AppColors.accentColor, lineWidth: 1.5)
                                              .background(AppColors.dataFilterGendersBg)
                              )
                      })
                  }.padding()
              }.background(
                  NavigationLink(destination: VisitedProfile(userID: request.id, userName: request.name)) {
                      EmptyView()
                  }.hidden()
              )
        }
    }
}

struct FriendRequestCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestCell( request: UserPreviewModel(id: 1, name: "John Smith", image: "https://sln-storage.s3.us-east-2.amazonaws.com/user/default.png", ideal: "Business"))
            .environmentObject(ProfileViewModel())
    }
}
