import UIKit

class TabNavigatorVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureTabs()
    }

  private func configure() {
    self.tabBar.tintColor = .label
    UINavigationBar.appearance().tintColor = .systemTeal
  }

  private func configureTabs() {
    let trendingTab = UINavigationController(rootViewController: TrendingFeedVC()),
    searchTab = UINavigationController(rootViewController: SearchVC())
    
    trendingTab.tabBarItem = UITabBarItem(title: "Trending", image: .init(systemName: "chart.line.uptrend.xyaxis"), tag: 0)
    searchTab.tabBarItem = UITabBarItem(title: "Search", image: .init(systemName: "magnifyingglass"), tag: 1)

    setViewControllers([trendingTab, searchTab], animated: true)

  }

}
