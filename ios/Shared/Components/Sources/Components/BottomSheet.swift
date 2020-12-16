//
//  BottomSheet.swift
//  
//
//  Created by Gareth Miller on 26/11/2020.
//

import Foundation
import SwiftUI
import Theming

private enum Constants {
  static let cornerRadius: CGFloat = 16
  static let indicatorWidth: CGFloat = 60
  static let indicatorHeight: CGFloat = 6
  static let minHeightRatio: CGFloat = 0.15
}

public struct BottomSheetView<Content: View>: View {
  
  private let maxHeight: CGFloat
  private let minHeight: CGFloat
  private let content: Content
  private let labelText: String
  
  @GestureState private var translation: CGFloat = 0
  @Binding private var isOpen: Bool
  
  public init(isOpen: Binding<Bool>, maxHeight: CGFloat, labelText: String, @ViewBuilder content: () -> Content) {
    self.minHeight = min(maxHeight * Constants.minHeightRatio, 50)
    self.maxHeight = maxHeight
    self.content = content()
    self.labelText = labelText
    _isOpen = isOpen
  }
  
  private var offset: CGFloat {
    isOpen ? 0 : maxHeight - minHeight
  }
  
  private var indicator: some View {
    RoundedRectangle(cornerRadius: Constants.cornerRadius)
      .fill(ColorManager.appPrimary)
      .frame(
        width: Constants.indicatorWidth,
        height: Constants.indicatorHeight)
      .padding()
      .onTapGesture {
        isOpen.toggle()
      }
  }
  
  private var showListButton: some View {
    Button(action: {
      isOpen.toggle()
    }, label: {
      Text(labelText)
        .foregroundColor(ColorManager.appPrimary)
    })
    .padding()
  }
  
  private var dragGesture: some Gesture {
    DragGesture().updating($translation) { value, state, _ in
      state = value.translation.height
    }.onEnded { value in
      isOpen = value.translation.height < 0
    }
  }
  
  public var body: some View {
    GeometryReader { geometry in
      VStack(spacing: 0) {
        if isOpen {
          indicator
        } else {
          showListButton
        }
        content
      }
      .frame(width: geometry.size.width, height: maxHeight, alignment: .top)
      .background(Color.white)
      .cornerRadius(Constants.cornerRadius)
      .frame(height: geometry.size.height, alignment: .bottom)
      .offset(y: max(offset + translation, 0))
      .animation(.easeInOut)
      .gesture(
        dragGesture
      )
    }
  }
}
