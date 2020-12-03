//
//  SignUpUserEntryView.swift
//  iosHackthonApp
//
//  Created by Raynelle Francisca on 18/11/2020.
//  Copyright © 2020 orgName. All rights reserved.
//

import SwiftUI
import Strings
import Theming

public struct SignUpUserEntryView<Content: View>: View {
	
	@ObservedObject private var viewModel: SignUpUserEntryViewModel
	private var destinationView: Content
	
	public init(viewModel: SignUpUserEntryViewModel, destinationView: Content) {
		self.viewModel = viewModel
		self.destinationView = destinationView
	}
	
	public var body: some View {
		VStack(alignment: .trailing) {
			Spacer()
			HStack {
				if viewModel.isSignupWithEmail {
					TextField(viewModel.textFieldPlaceholder, text: $viewModel.entryField)
                        .modifier(viewModel.textFieldStyle)
				} else {
					SecureField(viewModel.textFieldPlaceholder, text: $viewModel.entryField)
                        .modifier(viewModel.textFieldStyle)
				}
			}
			HStack {
				ZStack {
					if viewModel.isLoading {
						ProgressView()
							.zIndex(1)
					}
					
					NavigationLink(destination: destinationView, isActive: $viewModel.moveToNextScreen ) {
						Text("")
					}
					Button(action: {
						viewModel.signUp()
					}) {
						Text(viewModel.buttonTitle)
							.modifier(AddButtonStyle(width: viewModel.width, backgroundColor: viewModel.buttonBgColor))
					}
					.disabled(viewModel.entryField.isEmpty)
					.zIndex(0)
				}
			}
		}
	}
}
