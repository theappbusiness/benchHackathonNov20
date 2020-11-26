//
//  MealMapView.swift
//  
//
//  Created by Raynelle Francisca on 24/11/2020.
//

import SwiftUI
import shared
import CoreLocation
import Theming
import Strings

public struct MealMapView: View {
	
	@ObservedObject private var viewModel: MealListViewModel
    @State private var bottomSheetShown = false
	
	public init(viewModel: MealListViewModel) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
        GeometryReader { geometry in
            VStack {
                if viewModel.meals.isEmpty {
                    Text("No meals found") // TODO: Do something nicer than this
                }
                ZStack {
                    MapView(annotations: viewModel.locations, selectedPlace: $viewModel.selectedPlace)
                        .edgesIgnoringSafeArea(.all)
                    BottomSheetView(viewModel: viewModel, maxHeight: geometry.size.height * 0.7) {
                        MealListView(viewModel: viewModel)
                    }
                }
            }
            .navigationBarTitle(Strings.MealListScreen.title)
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.viewModel.loadMeals()
                                    }, label: {
                                        Image(systemName: Strings.MealListScreen.Images.reload)
                                            .foregroundColor(.white)
                                    }))
            .onAppear(perform: {
                viewModel.loadMeals()
            })
        }
	}
}

struct BottomSheetView<Content: View>: View {
    var viewModel: MealListViewModel

    let maxHeight: CGFloat
    let minHeight: CGFloat
    let content: Content

    init(viewModel: MealListViewModel, maxHeight: CGFloat, @ViewBuilder content: () -> Content) {
        self.minHeight = maxHeight * 0.1
        self.maxHeight = maxHeight
        self.content = content()
        self.viewModel = viewModel
    }

    private var offset: CGFloat {
        viewModel.isOpen ? 0 : maxHeight - minHeight
    }

    private var indicator: some View {
        return Button("Show list") {
            viewModel.isOpen.toggle()
        }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                if !viewModel.isOpen {
                    self.indicator.padding()
                } 
                self.content
            }
            .frame(width: geometry.size.width, height: self.maxHeight, alignment: .top)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(5)
            .frame(height: geometry.size.height, alignment: .bottom)
            .offset(y: self.offset)
            .animation(.easeInOut)
        }
    }
}
