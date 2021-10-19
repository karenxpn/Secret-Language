//
//  OTPTextFieldView.swift
//  Secret Language
//
//  Created by Karen Mirakyan on 01.06.21.
//

import SwiftUI
import SwiftUIX

struct OTPTextFieldView: View {
    
    var maxDigits: Int = 6
    
    @State var pin: String = ""
    
    var handler: (String) -> Void
    
    var body: some View {
        ZStack {
            pinDots
            backgroundField
        }
    }
    
    private var pinDots: some View {
        HStack(spacing:14) {
            ForEach(0..<maxDigits) { index in
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(AppColors.accentColor)
                        .frame(width: 45, height: 45)
                    
                    Text(self.getDigits(at: index))
                        .foregroundColor(.black)
                        .font(.custom("Gilroy-Regular", size: 30))
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var backgroundField: some View {
        let boundPin = Binding<String>(get: { self.pin }, set: { newValue in
            self.pin = newValue
            self.submitPin()
        })
        
        return CocoaTextField("", text: boundPin, onCommit: submitPin)
            .keyboardType(.numberPad)
            .foregroundColor(.clear)
            .accentColor(.clear)
    }
    
    
    private func submitPin() {
        guard !pin.isEmpty else {
            return
        }
        
        if pin.count == maxDigits {
            
            handler(pin)
        }
        
        // this code is never reached under  normal circumstances. If the user pastes a text with count higher than the
        // max digits, we remove the additional characters and make a recursive call.
        if pin.count > maxDigits {
            pin = String(pin.prefix(maxDigits))
            submitPin()
        }
    }
    
    private func getDigits(at index: Int) -> String {
        if index >= self.pin.count {
            return ""
        }
        
        return self.pin.digits[index].numberString
    }
}



struct PasscodeField_Previews: PreviewProvider {
    static var previews: some View {
        OTPTextFieldView { otp in }
    }
}
