//
//  DateFilterField.swift
//  SamayGo
//
//  Created by Diana Ayala Galvan on 11/07/26.
//

import SwiftUI

struct DateFilterField: View {
    let placeholder: String
    @Binding var date: Date?

    var body: some View {
        HStack {
            Text(date != nil ? formatted(date!) : placeholder)
                .font(.system(size: 16))
                .foregroundStyle(date != nil ? Color(hex: "#1E1E1E") : Color(hex: "#D9D9D9"))
            Spacer()
            Image(systemName: "calendar")
                .foregroundStyle(Color(hex: "#1E1E1E"))
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(hex: "#1E1E1E").opacity(0.3), lineWidth: 1)
        )
    }

    private func formatted(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter.string(from: date)
    }
}
