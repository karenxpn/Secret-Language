//
//  Search.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 10.06.21.
//

import SwiftUI

struct Search: View {
    @ObservedObject var searchVM = SearchViewModel()
    @State private var showFilter: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Background()
                
                ScrollView( showsIndicators: false ) {
                    VStack ( alignment: .leading, spacing: 20 ){
                        HStack {
                            
                            TextField(NSLocalizedString("globalSearch", comment: ""), text: $searchVM.search)
                                .font(.custom("Gilroy-Regular", size: 14))
                                .padding(.horizontal)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 25)
                                                .strokeBorder(Color.black, lineWidth: 2)
                                                .background(
                                                    RoundedRectangle(cornerRadius: 25)
                                                        .fill(AppColors.boxColor)))
                            
                            Image("search")
                        }
                        
                        VStack( alignment: .leading, spacing: 10) {
                            Text( NSLocalizedString("idealFor", comment: ""))
                                .foregroundColor(.white)
                                .font(.custom("times", size: 26))
                            
                            Text( NSLocalizedString("chooseCategory", comment: ""))
                                .foregroundColor(AppColors.accentColor)
                                .font(.custom("Gilroy-Regular", size: 14))
                        }
                        
                        HStack {
                            ForEach( searchVM.ideals, id: \.id ) { ideal in
                                Spacer()
                                
                                VStack( spacing: 4) {
                                    
                                    Button {
                                        withAnimation {
                                            searchVM.ideal = ideal.id
                                            
                                        }
                                    } label: {
                                        Text( ideal.name )
                                            .font(.custom("times", size: 16))
                                            .foregroundColor(searchVM.ideal == ideal.id ? AppColors.accentColor : .gray)
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 18)
                                            .background(RoundedRectangle(cornerRadius: 4)
                                                            .strokeBorder(searchVM.ideal == ideal.id ? AppColors.accentColor : Color.clear, lineWidth: 1)
                                                            .background(searchVM.ideal == ideal.id ? .black : AppColors.boxColor)
                                            )
                                    }
                                }
                                Spacer()
                            }
                        }
                    }.padding()
                    
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)

                    if searchVM.loading {
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                    } else {
                        LazyVGrid( columns: columns, content: {
                            ForEach(searchVM.searchResults, id: \.id ) { result in
                                SingleSearchResult(user: result)
                                    .environmentObject(searchVM)
                            }
                        })
                    }
                    
                    AllRightsReservedMadeByDoejo()
                        .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)

                }.padding(.top, 1)
                
                CustomAlert(isPresented: $searchVM.showAlert, alertMessage: searchVM.alertMessage, alignment: .center)
                    .offset(y: searchVM.showAlert ? 0 : UIScreen.main.bounds.size.height)
                    .animation(.interpolatingSpring(mass: 0.3, stiffness: 100.0, damping: 50, initialVelocity: 0))
                
            }.navigationBarTitle("")
            .navigationBarTitleView(SearchNavBar(title: "Community" ), displayMode: .inline)
            .onAppear(perform: {
                searchVM.getIdealCategories()
            }).navigationBarItems(trailing: Button(action: {
                showFilter.toggle()
            }, label: {
                Image( "filterIcon" )
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .padding([.leading, .top, .bottom])
            }))
            .fullScreenCover(isPresented: $showFilter, content: {
                SearchFilter()
                    .environmentObject(searchVM)
            })
            
        }.navigationViewStyle(StackNavigationViewStyle())
        .gesture(DragGesture().onChanged({ _ in
            UIApplication.shared.endEditing()
        }))
    }
}

struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}
