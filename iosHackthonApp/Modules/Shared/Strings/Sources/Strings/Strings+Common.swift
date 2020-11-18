import Foundation

public extension Strings {
    enum Common {}
}
public extension Strings.Common {
    enum ErrorAlert {}
    enum Images {}
    enum Date {}

    static let ok = "Ok"
    static let sorry = "Sorry!"
    static let km = "km"
    static let twoDecimal = "%.2f"
    static let unknown = "Unknown"
}
public extension Strings.Common.ErrorAlert {
    static let message = "There was an error creating your meal.\n please try again"
}
public extension Strings.Common.Images {
    static let hotFood = "flame"
    static let coldFood = "snow"
    static let location = "location"
}
public extension Strings.Common.Date {
    static let americanFormat = "yyyy-MM-dd' 'HH:mm:ssZ"
    static let nameDayMonth = "E d MMM"
}
