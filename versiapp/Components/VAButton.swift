import UIKit

class RoundedBorderButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = .white
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.borderWidth = 2
    self.layer.borderColor = UIColor.white.cgColor
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
