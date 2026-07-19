//
//  AlertCardView.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 11/07/26.
//

import SwiftUI

struct AlertCardView: View {
    let alert: MonitorAlert

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(alert.title)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                Spacer()
                Text(alert.formattedDate)
                    .font(.system(size: 13))
            }
            Text(alert.value)
                .font(.system(size: 22))
                .fontWeight(.bold)
            Text(alert.subtitle)
                .font(.system(size: 14))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(Color(hex: "#322222"))
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14)
                .stroke(alert.severity.color, lineWidth: 1.5)
        )
    }
}
