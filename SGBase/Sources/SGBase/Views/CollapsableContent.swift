//
//  CollapsableContent.swift
//
//
//  Created by Alex Jang on 3/7/24.
//

import SwiftUI

public struct CollapsableContent<CollapseContent: View, ExpandedContent: View>: View {
    
    @Binding private var isExpanded: Bool
    
    private let collapseContent: () -> CollapseContent
    private let expandedContent: () -> ExpandedContent
    
    public init(
        isExpanded: Binding<Bool>,
        @ViewBuilder collapseContent: @escaping () -> CollapseContent,
        @ViewBuilder expandedContent: @escaping () -> ExpandedContent
    ) {
        self._isExpanded = isExpanded
        self.collapseContent = collapseContent
        self.expandedContent = expandedContent
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            self.collapseContent()
                .onTapGesture {
                    withAnimation {
                        self.isExpanded.toggle()
                    }
                }
            self.expandedContent()
                .frame(
                    maxWidth: .infinity,
                    maxHeight: self.isExpanded ? .none : .zero
                )
                .allowsHitTesting(self.isExpanded)
                .clipped()
        }
    }
    
}
