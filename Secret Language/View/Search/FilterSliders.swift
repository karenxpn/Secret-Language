//
//  FilterSliders.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 04.10.21.
//

import SwiftUI
import Sliders

struct FilterSliders: View {
    
    let title: String
    let bounds: ClosedRange<Int>
    @Binding var range: ClosedRange<Int>
    
    var body: some View {
        VStack( alignment: .leading, spacing: 0) {
            Text("\(title) \(String(range.lowerBound))-\(String(range.upperBound))")
                .font(.custom("Gilroy-Regular", size: 12))
                .foregroundColor(.gray)
                .padding(.vertical)
            
            RangeSlider(range: $range,
                        in: bounds)
                .rangeSliderStyle(
                        HorizontalRangeSliderStyle(
                            track:
                                HorizontalRangeTrack(
                                    view: Capsule().foregroundColor(AppColors.accentColor)
                                )
                                .background(Capsule().foregroundColor(AppColors.accentColor.opacity(0.25)))
                                .frame(height: 5),
                            lowerThumb: Circle().foregroundColor(AppColors.accentColor),
                            upperThumb: Circle().foregroundColor(AppColors.accentColor),
                            lowerThumbSize: CGSize(width: 24, height: 24),
                            upperThumbSize: CGSize(width: 24, height: 24),
                            options: .forceAdjacentValue
                        )
                    )
        }
    }
}

struct FilterSliders_Previews: PreviewProvider {
    static var previews: some View {
        FilterSliders(title: "Age Range:", bounds: 18...99, range: .constant(18...100))
    }
}
