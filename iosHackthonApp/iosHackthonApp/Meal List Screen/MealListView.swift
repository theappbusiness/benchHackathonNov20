import SwiftUI
import shared
import CoreLocation

struct MealListView: View {

    @ObservedObject private(set) var viewModel: MealListViewModel

    var body: some View {
        ZStack {}
            .alert(isPresented: $viewModel.showingNoMoreAvailableError) {
                Alert(
                    title: Text(Strings.Common.sorry),
                    message: Text(Strings.MealListScreen.UnavailableAlert.message),
                    dismissButton: .default(Text(Strings.Common.ok)))
            }
        ZStack {}
            .alert(isPresented: $viewModel.showingCollectionCode) {
                Alert(
                    title: Text(viewModel.code),
                    message: Text(Strings.MealListScreen.CollectionAlert.message),
                    dismissButton: .default(Text(Strings.Common.ok)))
            }

        ScrollView {
            LazyVStack {
                ForEach((0 ..< viewModel.meals.count), id: \.self) {
                    MealRow(listViewModel: viewModel, rowViewModel: MealRowViewModel(mealWithDistance: viewModel.meals[$0]))
                        .padding()
                }
            }
        }
        .navigationBarTitle(Strings.MealListScreen.title)
        .navigationBarItems(trailing:
                                Button(action: {
                                    self.viewModel.loadMeals(forceReload: true)
                                }, label: {
                                    Image(systemName: Strings.MealListScreen.Images.reload)
                                        .foregroundColor(.black)
                                }))
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.showingError) {
            Alert(
                title: Text(Strings.Common.sorry),
                message: Text(Strings.Common.ErrorAlert.message),
                dismissButton: .default(Text(Strings.Common.ok)))
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: MealListViewModel(sdk: MealsSDK(), locationManager: LocationManager()))
    }
}

extension Meal: Identifiable { }
extension Quantity: Identifiable { }
