import Foundation

public extension Strings {
  enum AddMealScreen {}
}
public extension Strings.AddMealScreen {
  enum CollectionAlert {}
  
  static let title = "Title"
  static let additionalInfo = "Additional Information"
  static let quantity = "Quantity"
  static let temperature = "Temperature"
  static let hot = "Hot"
  static let cold = "Cold"
  static let availableFrom = "Available From"
  static let useBy = "Use By"
  static let address = "Address"
  static let addMeal = "Add A Meal"
  static let titlePlaceholder = "Enter a Title"
  static let additionalInfoPlaceholder = "Enter Additional Information"
  static let quantityPlaceholder = "Enter Quantity"
}
public extension Strings.AddMealScreen.CollectionAlert {
  static let message = "When someone arrives to collect this meal they will quote the above code"
}
