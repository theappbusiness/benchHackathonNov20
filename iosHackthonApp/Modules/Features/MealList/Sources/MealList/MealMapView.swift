//
//  MealMapView.swift
//  
//
//  Created by Raynelle Francisca on 24/11/2020.
//

import SwiftUI
import shared
import CoreLocation
import Strings
import AddMeal

public struct MealMapView: View {
	
	@ObservedObject private var viewModel: MealListViewModel
	
	public init(viewModel: MealListViewModel) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
		VStack {
			if viewModel.meals.isEmpty {
				Text("No meals found") // TODO: Do something nicer than this
			}
			ZStack {
				MapView(annotations: viewModel.locations, selectedPlace: $viewModel.selectedPlace)
					.edgesIgnoringSafeArea(.all)
			}
		}
		.navigationBarTitle(Strings.MealListScreen.title)
        .navigationBarItems(leading:
                                NavigationLink(destination: AddMealView(sdk: viewModel.sdk,
                                                                        locationManager: viewModel.locationManager),
                                               label: {
                                                Image(systemName: "plus")
                                                    .foregroundColor(.white)
                                               }),
                            trailing:
                                Button(action: {
                                    self.viewModel.loadMeals(forceReload: true)
                                }, label: {
                                    Image(systemName: Strings.MealListScreen.Images.reload)
                                        .foregroundColor(.white)
                                }))
		.onAppear(perform: {
			viewModel.loadMeals(forceReload: true)
		})
	}
}
