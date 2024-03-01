import Foundation


// MARK - URLs
let BASE_URL = "https://api.github.com/search"
let trendingURL = "\(BASE_URL)/repositories?q=Swift\(starsDescendingSegment)"
let searchURL = "\(BASE_URL)/repositories?q="
let starsDescendingSegment = "&sort=stars&order=desc"
let readmeSegment = "/blob/master/README.md"

// Mark - TableView Cell Spacing
let tableViewCellSpacing: CGFloat = 8
