import UIKit

class VACardCell: UITableViewCell {
  static let identifier = "VATrendingRepoCell"

  public private(set) lazy var cardTitle = UILabel()
  private lazy var cardDescription = UILabel()
  private lazy var cardImage = UIImageView()
  private lazy var cardStars = UILabel()
  private lazy var cardProgramingLanguage = UILabel()
  private lazy var cardWatchers = UILabel()
  private lazy var cardButton = UIButton(type: .system)
  private lazy var container = UIView()

  lazy var cardStatus = UIStackView()

  var repo: Repository!


  override func layoutSubviews() {
      super.layoutSubviews()
  }

  func configureCell (repository repo: Repository) {
    self.repo = repo

    configure()
    initUIWithData()
    configureSubViews()
    configureTitleAndDescription()
    layoutConstraints()

//    self.dropShadow(color: .black, offset: .init(width: 10, height: 80))
  }

  private func configure() {
    container.layer.cornerRadius = 18
    container.backgroundColor = .systemBlue
  }

  private func initUIWithData(){
    cardTitle.text = self.repo.name
    cardDescription.text = self.repo.repo_description
    cardImage.image = UIImage(named: "home")
    cardStars.text = self.repo.numberOfForks
    cardWatchers.text = self.repo.contributors
    cardProgramingLanguage.text = self.repo.language
  }

  private func configureSubViews(){
    self.addSubview(container)
    container.addSubview(cardTitle)
    container.addSubview(cardDescription)
    container.addSubview(cardImage)

    configureStatusView()

    container.addSubview(cardStatus)
    container.addSubview(cardButton)

    cardButton.setTitle("Readme", for: .normal)
  }

  private func configureStatusView() {
    let starsIcon = UIImageView(image:  UIImage(systemName: "star")),
        plIcon = UIImageView(image: UIImage(systemName: "button.angledtop.vertical.left")),
    watchersIcon = UIImageView(image: UIImage(systemName: "eye"))

    starsIcon.tintColor = .label
    plIcon.tintColor = .label
    watchersIcon.tintColor = .label

    let stackViews = [
      UIStackView(arrangedSubviews: [starsIcon, cardStars]),
      UIStackView(arrangedSubviews: [plIcon, cardProgramingLanguage]),
      UIStackView(arrangedSubviews: [watchersIcon, cardWatchers])
    ]

    for stackView in stackViews {
      stackView.axis = .horizontal
      stackView.distribution = .equalCentering
      stackView.alignment = .center
      stackView.spacing = 8
      cardStatus.addArrangedSubview(stackView)
    }

    cardStatus.axis = .horizontal
    cardStatus.spacing = 4
    cardStatus.distribution = .equalCentering
    cardStatus.alignment = .center
  }

  private func configureTitleAndDescription() {
    cardTitle.textAlignment = .center
    cardDescription.textAlignment = .center
    cardTitle.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    cardDescription.font = UIFont.systemFont(ofSize: 18, weight: .regular)
    cardStars.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    cardProgramingLanguage.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    cardWatchers.font = UIFont.systemFont(ofSize: 12, weight: .bold)
  }

  private func layoutConstraints(){
    var constraints: [NSLayoutConstraint] = []

    container.translatesAutoresizingMaskIntoConstraints = false
    cardTitle.translatesAutoresizingMaskIntoConstraints = false
    cardDescription.translatesAutoresizingMaskIntoConstraints = false
    cardImage.translatesAutoresizingMaskIntoConstraints = false
    cardStatus.translatesAutoresizingMaskIntoConstraints = false
    cardButton.translatesAutoresizingMaskIntoConstraints = false


    constraints += [
      container.topAnchor.constraint(equalTo: self.topAnchor, constant: tableViewCellSpacing),
      container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -tableViewCellSpacing),
      container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    ]

    constraints +=  [
      cardTitle.topAnchor.constraint(equalTo: container.topAnchor, constant: 8),
      cardTitle.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
      cardTitle.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
    ]

    constraints += [
      cardDescription.topAnchor.constraint(equalTo: cardTitle.bottomAnchor, constant: 12),
      cardDescription.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
      cardDescription.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
    ]

    constraints += [
      cardImage.topAnchor.constraint(equalTo: cardDescription.topAnchor, constant: 12),
      cardImage.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      cardImage.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      cardImage.heightAnchor.constraint(equalToConstant: 200)
    ]

    constraints += [
      cardStatus.topAnchor.constraint(equalTo: cardImage.bottomAnchor, constant: 12),
      cardStatus.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 60),
      cardStatus.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -60),

    ]

    constraints += [
      cardButton.topAnchor.constraint(equalTo: cardStatus.bottomAnchor, constant: 16),
      cardButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
      cardButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
      cardButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -16)
    ]

    NSLayoutConstraint.activate(constraints)
  }


}
