import UIKit

extension UITabBar {
    func change(color: UIColor) {
        let appearance = UITabBarAppearance()
        setTabBarItemColors(appearance.stackedLayoutAppearance,color)
        setTabBarItemColors(appearance.inlineLayoutAppearance, color)
        setTabBarItemColors(appearance.compactInlineLayoutAppearance, color)
        
        self.standardAppearance = appearance
    }
}


@available(iOS 13.0, *)
private func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance, _ color: UIColor) {
    itemAppearance.selected.iconColor = Styles.Color.appBaseColor
    itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: Styles.Color.appBaseColor]
}

