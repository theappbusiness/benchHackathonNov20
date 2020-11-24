import SwiftUI
import shared
import CoreLocation
import Strings
import AddMeal

public struct MealListView: View {
	
	@ObservedObject private var viewModel: MealListViewModel
	
	public init(viewModel: MealListViewModel) {
		self.viewModel = viewModel
	}
	
	public var body: some View {
		VStack {
			if viewModel.meals.isEmpty {
				Text("No meals found") // TODO: Do something nicer than this
			}
			
			ScrollView {
				LazyVStack {
					ForEach((0 ..< viewModel.meals.count), id: \.self) {
						MealRow(listViewModel: viewModel, rowViewModel: MealRowViewModel(meal: viewModel.meals[$0]))
							.padding()
					}
				}
			}
			.navigationBarTitle(Strings.MealListScreen.title)
            .navigationBarItems(leading:
                                    Button(action: { viewModel.isAddMealShowing = true }) {
                                        Image(systemName: Strings.Common.Images.add)
                                    },
                                trailing:
                                    Button(action: {
                                        self.viewModel.loadMeals(forceReload: true)
                                    }, label: {
                                        Image(systemName: Strings.MealListScreen.Images.reload)

                                    }))
                .foregroundColor(.white)
            .sheet(isPresented: $viewModel.isAddMealShowing, content: {
                AddMealView(sdk: viewModel.sdk, locationManager: viewModel.locationManager)
            })
			.alert(isPresented: $viewModel.showingAlert) {
				switch viewModel.activeAlert {
				case .unavailable:
					return  Alert(
						title: Text(Strings.Common.sorry),
						message: Text(Strings.MealListScreen.UnavailableAlert.message),
						dismissButton: .default(Text(Strings.Common.ok)))
				case .collection:
					return Alert(
						title: Text(viewModel.code),
						message: Text(Strings.MealListScreen.CollectionAlert.message),
						dismissButton: .default(Text(Strings.Common.ok)))
				case .error:
					return Alert(
						title: Text(Strings.Common.sorry),
						message: Text(Strings.Common.ErrorAlert.message),
						dismissButton: .default(Text(Strings.Common.ok)))
				}
			}
		}
		.onAppear(perform: {
			viewModel.loadMeals(forceReload: true)
		})
	}
}

extension Meal: Identifiable { }
extension Quantity: Identifiable { }
