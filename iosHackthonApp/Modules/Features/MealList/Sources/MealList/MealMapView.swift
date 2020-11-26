//
//  MealMapView.swift
//  
//
//  Created by Raynelle Francisca on 24/11/2020.
//

import SwiftUI
import shared
import Theming
import Strings
import Components

public struct MealMapView: View {
	
	@ObservedObject private var viewModel: MealListViewModel

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
                    BottomSheetView(isOpen: $viewModel.bottomSheetOpen, maxHeight: geometry.size.height * 0.7) {
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
