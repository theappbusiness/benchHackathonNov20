//
//  MealMapView.swift
//  
//
//  Created by Raynelle Francisca on 24/11/2020.
//

import SwiftUI
import shared
import Strings
import Components
import AddMeal

public struct MealMapView: View {
    
    @ObservedObject private var viewModel: MealListViewModel
    
    public init(viewModel: MealListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                if viewModel.meals.isEmpty {
                    Text(viewModel.noMeals) // TODO: Do something nicer than this
                }
                ZStack {
                    MapView(annotations: viewModel.locations, selectedPlace: $viewModel.selectedPlace)
                        .edgesIgnoringSafeArea(.all)
                    BottomSheetView(isOpen: $viewModel.bottomSheetOpen,
                                        maxHeight: geometry.size.height * 0.7,
                                        labelText: viewModel.bottomSheetLabel) {
                        MealListView(viewModel: viewModel)

                    }
                }
            }
            .navigationBarTitle(viewModel.title)
            .navigationBarItems(leading:
                                    Button(action: {
                                        viewModel.isAddMealShowing = true
                                    }) {
                                        Image(systemName: viewModel.addImage)
                                    },
                                trailing:
                                    Button(action: {
                                        self.viewModel.loadMeals()
                                    }, label: {
                                        Image(systemName: viewModel.reloadImage)
                                    }))
            .foregroundColor(.white)
            .sheet(isPresented: $viewModel.isAddMealShowing, content: {
                AddMealView(sdk: viewModel.sdk, locationManager: viewModel.locationManager)
            })
            .onAppear(perform: {
                viewModel.loadMeals()
            })
        }
    }
}
