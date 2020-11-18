import Foundation

public extension Strings {
    enum MealListScreen {}
}
public extension Strings.MealListScreen {
    enum SegmentControl {}
    enum Map {}
    enum UnavailableAlert {}
    enum CollectionAlert {}
    enum Button {}
    enum Images {}

    static let title = "Meals in your area"
    static let portion = "portion remaining"
    static let portions = "portions remaining"
    static let available = "Available: "
    static let expiresAt = " Expires: "
}
public extension Strings.MealListScreen.SegmentControl {
    static let map = "Map"
    static let list = "List"
}
public extension Strings.MealListScreen.Map {
    static let missing = "Missing place information"
    static let reserved = "All meals reserved"
}
public extension Strings.MealListScreen.UnavailableAlert {
    static let message = "This meal is no longer available"
}
public extension Strings.MealListScreen.CollectionAlert {
    static let message = "When you go to collect this meal, you will be asked for the above code"
}
public extension Strings.MealListScreen.Button {
    static let disabledText = "Unavailable"
    static let enabledText = "Reserve a portion"
}
public extension Strings.MealListScreen.Images { // TODO: These probably belong in components or theming
    static let hotFood = "bowl-black"
    static let coldFood = "salad-black"
    static let hotFoodGrey = "bowl-grey"
    static let coldFoodGrey = "salad-grey"
    static let info = "info.circle"
    static let location = "mappin.and.ellipse"
    static let fromTime = "clock"
    static let expireTime = "hourglass"
    static let quantity = "number"
    static let reload = "arrow.clockwise"
}
