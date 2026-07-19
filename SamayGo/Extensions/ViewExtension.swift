//
//  ViewExtension.swift
//  SamayGo
//
//  Created by Diana Del Milagro Ayala Galvan on 18/07/26.
//

import SwiftUI

// 1. Define the modifier
struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    var duration: TimeInterval = 2.0
    
    func body(content: Content) -> some View {
        ZStack {
            content // Your main screen content
            
            if isShowing {
                VStack {
                    Spacer() // Pushes toast to the bottom
                    
                    HStack(spacing: 12) {
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.white)
                        Text(message)
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 24)
                    .background(Color.black.opacity(0.85))
                    .cornerRadius(25)
                    .shadow(radius: 5)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .padding(.bottom, 40) // Keeps it safely above home indicator
                .onAppear {
                    // Automatically hide after the given duration
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation(.spring()) {
                            isShowing = false
                        }
                    }
                }
            }
        }
    }
}

// 2. Create an extension for a clean syntax
extension View {
    func toast(isShowing: Binding<Bool>, message: String, duration: TimeInterval = 2.0) -> some View {
        self.modifier(ToastModifier(isShowing: isShowing, message: message, duration: duration))
    }
}
