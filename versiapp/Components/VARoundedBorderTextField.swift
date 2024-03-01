import UIKit

class VARoundedBorderTextField: UITextField {
  let padding: CGFloat = 16

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])


    self.backgroundColor = .white
  
    self.layer.cornerRadius = 8
    self.layer.borderColor = UIColor.blue.cgColor
    self.layer.borderWidth = 2
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: padding , dy: padding)
  }

  override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.insetBy(dx: padding, dy: padding)
  }


}
