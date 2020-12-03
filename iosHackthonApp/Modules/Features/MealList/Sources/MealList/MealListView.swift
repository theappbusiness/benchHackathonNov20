import SwiftUI
import shared
import CoreLocation
import Strings
import Theming
import AddMeal

public struct MealListView: View {
    
    @ObservedObject private var viewModel: MealListViewModel
    
    public init(viewModel: MealListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            if viewModel.meals.isEmpty {
                Text(viewModel.noMeals) // TODO: Do something nicer than this
            }
            ScrollView {
                LazyVStack {
                    ForEach((0 ..< viewModel.meals.count), id: \.self) {
                        MealRow(listViewModel: viewModel, rowViewModel: MealRowViewModel(meal: viewModel.meals[$0]))
                            .padding()
                    }
                }
            }
            .sheet(isPresented: $viewModel.isAddMealShowing, content: {
                AddMealView(sdk: viewModel.sdk, locationManager: viewModel.locationManager)
            })
            .alert(isPresented: $viewModel.showingAlert) {
                switch viewModel.activeAlert {
                case .unavailable:
                    return  Alert(
                        title: Text(viewModel.sorry),
                        message: Text(viewModel.unavailableMessage),
                        dismissButton: .default(Text(Strings.Common.ok)))
                case .collection:
                    return Alert(
                        title: Text(viewModel.code),
                        message: Text(viewModel.collectionMessage),
                        dismissButton: .default(Text(viewModel.ok)))
                case .error:
                    return Alert(
                        title: Text(viewModel.sorry),
                        message: Text(viewModel.errorMessage),
                        dismissButton: .default(Text(viewModel.ok)))
                }
            }
        }
        .onAppear(perform: {
            viewModel.loadMeals()
        })
    }
}

extension Meal: Identifiable { }
extension Quantity: Identifiable { }
