//
//  FlowLayout.swift
//  SamayGo
//
//  Created by Diana Del Milagro Ayala Galvan on 19/07/26.
//

import SwiftUI

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        // Convert the proposed size into a concrete size structure
        let proposalSize = proposal.replacingUnspecifiedDimensions()
        let bounds = CGRect(origin: .zero, size: proposalSize)
        return layout(in: bounds, subviews: subviews, isTesting: true)
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        _ = layout(in: bounds, subviews: subviews, isTesting: false)
    }

    private func layout(in bounds: CGRect, subviews: Subviews, isTesting: Bool) -> CGSize {
        let maxWidth = bounds.width
        var currentX: CGFloat = bounds.minX
        var currentY: CGFloat = bounds.minY
        var currentRowHeight: CGFloat = 0
        var totalWidth: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)

            // Push view to the next line if it runs out of horizontal room
            if currentX + size.width > bounds.maxX && currentX > bounds.minX {
                currentX = bounds.minX
                currentY += currentRowHeight + spacing
                currentRowHeight = 0
            }

            if !isTesting {
                subview.place(at: CGPoint(x: currentX, y: currentY), proposal: .unspecified)
            }

            currentX += size.width + spacing
            currentRowHeight = max(currentRowHeight, size.height)
            totalWidth = max(totalWidth, currentX - bounds.minX)
        }

        return CGSize(width: totalWidth, height: currentY + currentRowHeight - bounds.minY)
    }
}


