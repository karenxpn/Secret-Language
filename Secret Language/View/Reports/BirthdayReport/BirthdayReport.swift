//
//  SingleReport.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 02.07.21.
//

import SwiftUI


struct BirthdayReport: View {
    
    @Binding var report: BirthdayReportModel?
    
    var body: some View {
        ZStack {
            Background()
            
            if report != nil {
                ScrollView( showsIndicators: false ) {
                                        
                    VStack {
                        Text( "\(NSLocalizedString("theSecretLanguageNameFor", comment: "")) \(report!.date_name) \(NSLocalizedString("is", comment: "")) ")
                            .foregroundColor(.white)
                            .font(.custom("times", size: 18))
                            .padding(.top)
                        
                        Text( report!.sln )
                            .foregroundColor(.white)
                            .font(.custom("times-italic", size: 18))
                            .fontWeight(.semibold)
                        
                        Text( report!.sln_description )
                            .foregroundColor(.accentColor)
                            .font(.custom("times-italic", size: 18))
                            .multilineTextAlignment(.center)
                            .padding(8)
                        
                        Text( "\(NSLocalizedString("since1701", comment: "")) \(report!.famous_years)")
                            .foregroundColor(.white)
                            .font(.custom("times", size: 16))
                            .multilineTextAlignment(.center)
                            .padding(8)
                    }.frame(width: .greedy)
                    .padding(.vertical)
                    .background(AppColors.boxColor)
                    
                    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
                    
                    LazyVGrid(columns: columns, alignment: .center) {
                        ReportGridItem(title: report!.day_report.date_name, image: report!.day_report.image, name: report!.day_report.day_name, destination: AnyView( DayReport( report: report!.day_report ) ))
                        
                        ReportGridItem(title: report!.week_report.date_span, image: report!.week_report.image, name: report!.week_report.name_long, destination: AnyView(WeekReport(report: report!.week_report)))
                        
                        ReportGridItem(title: report!.month_report.span1, image: report!.month_report.image, name: report!.month_report.name, destination: AnyView(MonthReport(report: report!.month_report)))
                        
                        ReportGridItem(title: report!.season_report.span1, image: report!.season_report.image, name: report!.season_report.name, destination: AnyView(SeasonReport(report: report!.season_report)))
                        
                        ReportGridItem(title: report!.path_report.prefix, image: report!.path_report.image, name: report!.path_report.name_medium, destination: AnyView(PathReport(report: report!.path_report)))
                        
                        ReportGridItem(title: NSLocalizedString("theirLifeJourneyRuns", comment: ""), image: report!.way_report.image, name: "\(NSLocalizedString("theWayOf", comment: "")) \(report!.way_report.name)", destination: AnyView(WayReport(report: report!.way_report)))
                        
                        ReportGridItem(title: report!.relationship_report.name, image: report!.relationship_report.image, name: "", destination: AnyView(RelationshipReport(report: .constant(report!.relationship_report))))
                        
                    }.padding(.horizontal, 8)
                    .padding(.bottom, UIScreen.main.bounds.size.height * 0.15)
                    .padding(.top)
                    
                }.padding( .top, 1)
            }
            
        }.navigationBarTitle( "" )
        .navigationBarTitleView(SearchNavBar(title: NSLocalizedString("birthdayReport", comment: "")), displayMode: .inline)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.shareReport(id: report!.shareId)
                                }, label: {
                                    Image( "shareIcon" )
                                        .frame( width: 40, height: 40)
                                }).disabled(report == nil)
        )
    }
    
    func shareReport( id: Int ) {
        let url = URL(string: "https://secretlanguage.network/v1/birthday/share?id=\(id)")!
        let av = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

struct BirthdayReport_Previews: PreviewProvider {
    static var previews: some View {
        BirthdayReport(report: .constant(PreviewParameters.birthdayReport))
    }
}
