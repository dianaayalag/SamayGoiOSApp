//
//  SmallButtonView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 8/07/26.
//

import SwiftUI

struct SmallButtonView: View {
    @State var text: String
    @State var altText: String
    @State var iconName: String
    
    @State var state = false
    
    var onTap: (SmallButtonView) -> Void

    @State var currentText: String
    @State var bgColor = Color.white
    @State var txtColor = Color.black

    init(text: String, altText: String, iconName: String, onTap: @escaping (SmallButtonView) -> Void) {
        _text = State(initialValue: text)
        _altText = State(initialValue: altText)
        _iconName = State(initialValue: iconName)
        self.onTap = onTap
        _currentText = State(initialValue: text)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .center) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(hex: "#E8F7FF"))
                Image(iconName)
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .frame(width: 48, height: 48)
           Text(currentText)
                .font(.system(size: 15))
                .foregroundStyle(txtColor)
        }
        .frame(width: 95, height: 115)
        .background(bgColor)
        .cornerRadius(15)
        .onTapGesture {
            onTap(self)
        }
        .onChange(of: state) {
            if state {
                txtColor = Color.white
                bgColor = Color(hex: "#624B8B")
                currentText = altText
            } else {
                txtColor = Color.black
                bgColor = Color.white
                currentText = text
            }
        }
    }
}

