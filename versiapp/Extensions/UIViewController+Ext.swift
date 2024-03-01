import UIKit
import SafariServices

extension UIViewController {
  func presentSFSafariVCFor(url: String){
    guard let readmeURL = URL(string: url + readmeSegment) else {return}
    let safariVC = SFSafariViewController(url: readmeURL)
    present(safariVC, animated: true, completion: nil)
  }
}
