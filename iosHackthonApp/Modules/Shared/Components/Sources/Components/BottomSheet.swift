//
//  BottomSheet.swift
//  
//
//  Created by Gareth Miller on 26/11/2020.
//

import Foundation
import SwiftUI
import Theming

public struct BottomSheetView<Content: View>: View {

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    public init(isOpen: Binding<Bool>, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * 0.1
        self.maxHeight = maxHeight
        self.content = content()
        _isOpen = isOpen
    }

    private var offset: CGFloat {
        isOpen ? 0 : maxHeight - minHeight
    }

    @GestureState private var translation: CGFloat = 0
    @Binding var isOpen: Bool

    public var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if isOpen {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(ColorManager.appPrimary)
                        .frame(
                            width: 60,
                            height: 6)
                        .padding()
                        .onTapGesture {
                            isOpen.toggle()
                        }
                } else {
                    Button("Show list") {
                        isOpen.toggle()
                    }
                    .padding()
                }
                content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color.white)
            .cornerRadius(16)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: max(self.offset + self.translation, 0))
            .animation(.easeInOut)
            .animation(.interactiveSpring())
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.height
                }.onEnded { value in
                    let snapDistance = self.maxHeight * 0.25
                    guard abs(value.translation.height) > snapDistance else {
                        return
                    }
                    self.isOpen = value.translation.height < 0
                }
            )
        }
    }
}

