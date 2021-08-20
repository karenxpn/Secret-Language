//
//  SharedBirthdayReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 22.07.21.
//

import SwiftUI

struct SharedBirthdayReport: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var reportVM = ReportViewModel()
    let reportID: Int
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Background()
                
                if reportVM.loading {
                    ProgressView()
                } else if reportVM.birthdayReport != nil {
                    ScrollView( showsIndicators: false ) {
                        
                        VStack {
                            Text( "\(NSLocalizedString("theSecretLanguageNameFor", comment: "")) \(reportVM.birthdayReport!.date_name) \(NSLocalizedString("is", comment: "")) ")
                                .foregroundColor(.white)
                                .font(.custom("times", size: 18))
                                .padding(.top)
                            
                            Text( reportVM.birthdayReport!.sln )
                                .foregroundColor(.white)
                                .font(.custom("times-italic", size: 18))
                                .fontWeight(.semibold)
                            
                            Text( reportVM.birthdayReport!.sln_description )
                                .foregroundColor(.accentColor)
                                .font(.custom("times-italic", size: 18))
                                .multilineTextAlignment(.center)
                                .padding(8)
                            
                            Text( "\(NSLocalizedString("since1701", comment: "")) \(reportVM.birthdayReport!.famous_years)")
                                .foregroundColor(.white)
                                .font(.custom("times", size: 16))
                                .multilineTextAlignment(.center)
                                .padding(8)
                        }.frame(width: .greedy)
                        .padding(.vertical)
                        .background(AppColors.boxColor)
                        
                        let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                        
                        LazyVGrid(columns: columns, alignment: .center) {
                            ReportGridItem(title: reportVM.birthdayReport!.day_report.date_name,
                                           image: reportVM.birthdayReport!.day_report.image,
                                           name: reportVM.birthdayReport!.day_report.day_name,
                                           destination: AnyView( DayReport( report: reportVM.birthdayReport!.day_report ) ))
                            
                            ReportGridItem(title: reportVM.birthdayReport!.week_report.date_span,
                                           image: reportVM.birthdayReport!.week_report.image,
                                           name: reportVM.birthdayReport!.week_report.name_long,
                                           destination: AnyView(WeekReport(report: reportVM.birthdayReport!.week_report)))
                            
                            ReportGridItem(title: reportVM.birthdayReport!.month_report.span1,
                                           image: reportVM.birthdayReport!.month_report.image,
                                           name: reportVM.birthdayReport!.month_report.name,
                                           destination: AnyView(MonthReport(report: reportVM.birthdayReport!.month_report)))
                            
                            ReportGridItem(title: reportVM.birthdayReport!.season_report.span1,
                                           image: reportVM.birthdayReport!.season_report.image,
                                           name: reportVM.birthdayReport!.season_report.name,
                                           destination: AnyView(SeasonReport(report: reportVM.birthdayReport!.season_report)))
                            
                            ReportGridItem(title: reportVM.birthdayReport!.path_report.prefix,
                                           image: reportVM.birthdayReport!.path_report.image,
                                           name: reportVM.birthdayReport!.path_report.name_medium,
                                           destination: AnyView(PathReport(report: reportVM.birthdayReport!.path_report)))
                            
                            ReportGridItem(title: NSLocalizedString("theirLifeJourneyRuns", comment: ""),
                                           image: reportVM.birthdayReport!.way_report.image,
                                           name: "\(NSLocalizedString("theWayOf", comment: "")) \(reportVM.birthdayReport!.way_report.name)",
                                           destination: AnyView(WayReport(report: reportVM.birthdayReport!.way_report)))
                            
                            ReportGridItem(title: reportVM.birthdayReport!.relationship_report.name,
                                           image: reportVM.birthdayReport!.relationship_report.image,
                                           name: "",
                                           destination: AnyView(RelationshipReport(report: .constant(reportVM.birthdayReport!.relationship_report))))
                            
                        }.padding(.horizontal, 8)
                        .padding(.top)
                        
                        AllRightsReservedMadeByDoejo()
                            .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)


                    }.padding( .top, 1)
                }
                
            }.navigationBarTitle( "" )
            .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("birthdayReport", comment: "")), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image("close")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 16, height: 16)
                    .padding([.leading, .top, .bottom])
                
            })
            ).onAppear {
                reportVM.getSharedBirthdayReport(reportID: reportID)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SharedBirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        SharedBirthdayReport(reportID: 1)
    }
}
