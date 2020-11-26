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
    static let unknown = "Unknown"
}
public extension Strings.Common.ErrorAlert {
    static let creatingMessage = "There was an error creating your meal.\n please try again"
    static let loadingMessage = "There was an error loading the meals.\n please try again"
}
public extension Strings.Common.Images {
    static let hotFood = "flame"
    static let coldFood = "snow"
    static let location = "location"
    static let add = "plus"
}
