import SwiftUI
import shared

struct MealListView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ZStack {}
            .alert(isPresented: $viewModel.showingCollectionCode) {
                Alert(
                    title: Text(viewModel.code),
                    message: Text(Strings.AddMealScreen.CollectionAlert.message),
                    dismissButton: .default(Text(Strings.Common.ok)))
            }

        ScrollView {
            LazyVStack {
                ForEach((0 ..< viewModel.meals.count), id: \.self) {
                    MealRow(viewModel: viewModel, meal: viewModel.meals[$0] as! Meal)
                        .padding()
                }
            }
        }
        .navigationBarTitle(Strings.MealListScreen.title)
        .navigationBarItems(trailing:
                                Button("Reload") {
                                    self.viewModel.loadMeals(forceReload: true)
                                })
        .navigationBarBackButtonHidden(true)
        .alert(isPresented: $viewModel.showingError) {
            Alert(
                title: Text(Strings.Common.sorry),
                message: Text(Strings.Common.ErrorAlert.message),
                dismissButton: .default(Text(Strings.Common.ok)))
        }
    }
}

extension MealListView {

    class ViewModel: ObservableObject {

        let sdk: MealsSDK
        @Published var meals = []
        @Published var code = ""
        @Published var showingCollectionCode = false
        @Published var showingError = false

        init(sdk: MealsSDK) {
            self.sdk = sdk
            self.loadMeals(forceReload: false)
        }

        func loadMeals(forceReload: Bool) {
            sdk.getMeals(forceReload: forceReload, completionHandler: { meals, error in
                if let meals = meals {
                    self.meals = meals
                }
            })
        }

        func patchMeal(meal: Meal) {
            let updatedMeal = sdk.getMeal(id: meal.id) { updatedMeal, error in

                guard let updatedMeal = updatedMeal else {
                    self.showingError.toggle()
                    return
                }
                let newMeal = Meal(id: meal.id, name: meal.name, quantity: updatedMeal.quantity - 1, availableFromDate: meal.availableFromDate, expiryDate: meal.expiryDate, info: meal.info, hot: meal.hot, locationLat: meal.locationLat, locationLong: meal.locationLong)
                self.sdk.patchMeal(meal: newMeal) { meal, error in
                    guard let meal = meal else {
                        self.showingError.toggle()
                        return
                    }
                    self.code = meal.id.last4Chars()
                    self.showingCollectionCode.toggle()
                }
            }
        }
    }
}

struct MealListView_Previews: PreviewProvider {
    static var previews: some View {
        MealListView(viewModel: MealListView.ViewModel(sdk: MealsSDK()))
    }
}

extension Meal: Identifiable { }
