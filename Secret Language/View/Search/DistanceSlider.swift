//
//  DistanceSlider.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 04.10.21.
//

import SwiftUI
import Sliders

struct DistanceSlider: View {
    let title: String
    @Binding var distance: Int
    
    var body: some View {
        VStack( alignment: .leading, spacing: 0) {
            Text("\(title) \(String( distance ))")
                .font(.custom("Gilroy-Regular", size: 12))
                .foregroundColor(.gray)
                .padding(.vertical)
            
            ValueSlider(value: $distance, in: 1...100000)
                .valueSliderStyle(
                    HorizontalValueSliderStyle(
                        track:
                            HorizontalTrack(view:
                                                Capsule().foregroundColor(AppColors.accentColor)
                                           )
                            .background(Capsule().foregroundColor(AppColors.accentColor.opacity(0.25)))
                            .frame(height: 5),
                        thumb: Circle().foregroundColor(AppColors.accentColor),
                        thumbSize: CGSize(width: 24, height: 24),
                        options: .interactiveTrack
                    )
                )
        }
    }
}

struct DistanceSlider_Previews: PreviewProvider {
    static var previews: some View {
        DistanceSlider(title: "Distance", distance: .constant(10))
    }
}
