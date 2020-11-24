import Foundation

public extension Strings {
	enum TabView {}
}
public extension Strings.TabView {
	enum Images {}
	
	static let heading = "CommunityKitchen"
	static let listViewText = "ListView"
	static let findButtonText = "Find a Meal"
	static let enableLocationText = "We will need access to your location in order to show you meals that are in your area.\n\nTo enable, tap the link below then navigate to:\n\nPrivacy\n↓\nLocation Services\n↓\nCommunityKitchen"
	static let settingsLinkText = "Allow location"
	static let settings = "Settings"
}
public extension Strings.TabView.Images {
	static let find = "map"
	static let settings = "gear"
	static let listView = "list.bullet"
}
