//
//  SignUpUserEntryViewModel.swift
//  
//
//  Created by Raynelle Francisca on 27/11/2020.
//

import Foundation
import SwiftUI

public final class SignUpUserEntryViewModel: ObservableObject {
  
  var signUp : () -> Void
  var isSignupWithEmail: Bool
  var textFieldPlaceholder: String
  var buttonTitle: String
  var width: CGFloat
  @Binding var entryField: String
  @Binding var moveToNextScreen: Bool
  @Binding var isLoading: Bool
  
  public init(isSignupWithEmail: Bool,
              textFieldPlaceholder: String,
              buttonTitle: String,
              width: CGFloat,
              entryField: Binding<String>,
              signUp : @escaping () -> Void,
              moveToNextScreen: Binding<Bool>,
              isLoading: Binding<Bool>) {
    self.isSignupWithEmail = isSignupWithEmail
    self.textFieldPlaceholder = textFieldPlaceholder
    self.buttonTitle = buttonTitle
    self.width = width
    _entryField = entryField
    self.signUp = signUp
    _moveToNextScreen = moveToNextScreen
    _isLoading = isLoading
  }
  
  var buttonBgColor: Color {
    entryField.isEmpty ? ColorManager.gray: ColorManager.appPrimary
  }
}
