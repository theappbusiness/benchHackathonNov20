import SwiftUI
import shared
import CoreLocation
import Strings

public struct MealListView: View {
    
    @ObservedObject private var viewModel: MealListViewModel
    
    public init(viewModel: MealListViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        
        VStack {
            if viewModel.meals.isEmpty {
                Text("No meals found") // TODO: Do something nicer than this
            } else {
                Picker(selection: $viewModel.showMap, label: Text("")) {
                    Text(Strings.MealListScreen.SegmentControl.list).tag(0)
                    Text(Strings.MealListScreen.SegmentControl.map).tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .padding()
            }
            
            if viewModel.showMap == 0 {
                ScrollView {
                    LazyVStack {
                        ForEach((0 ..< viewModel.meals.count), id: \.self) {
                            MealRow(listViewModel: viewModel, rowViewModel: MealRowViewModel(meal: viewModel.meals[$0]))
                                .padding()
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
            } else {
                ZStack {
                    MapView(annotations: viewModel.locations, selectedPlace: $viewModel.selectedPlace)
                        .edgesIgnoringSafeArea(.all)
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
