import UIKit
import RxSwift
import RxCocoa

class TrendingFeedVC: UIViewController {

  var disposeBag = DisposeBag()
  var dataSource = PublishSubject<[Repository]>()

  let refreshControl = UIRefreshControl()

  var tableView: UITableView!
  let vaRoundedBorderTextField = VARoundedBorderTextField()
  var repositories = [Repository]()

  override func viewDidLoad() {
    super.viewDidLoad()
    fetchRepositories()
    configure()
    setupTableView()
    configureRefreshControl()

    dataSource.bind(to: tableView.rx.items(cellIdentifier: VACardCell.identifier)) { (row, repo: Repository, cell: VACardCell) in
      cell.configureCell(repository: repo)
    }
    .disposed(by: disposeBag)
  }

  private func configure(){
    self.view.backgroundColor = .systemBackground
    vaRoundedBorderTextField.placeholder = "write something stupid"
    vaRoundedBorderTextField.translatesAutoresizingMaskIntoConstraints = false

    self.view.addSubview(vaRoundedBorderTextField)

    NSLayoutConstraint.activate([
      vaRoundedBorderTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 12),
      vaRoundedBorderTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
      vaRoundedBorderTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
    ])
  }

  private func setupTableView(){
    tableView = UITableView()
    tableView.allowsSelection = false
    tableView.separatorColor = .none
    tableView.refreshControl = refreshControl
    tableView.register(VACardCell.self, forCellReuseIdentifier: VACardCell.identifier)

    self.view.addSubview(tableView)

    tableView.bounds = self.view.bounds
    tableView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: vaRoundedBorderTextField.bottomAnchor, constant: 20),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
      tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor)
    ])
  }

  private func configureRefreshControl() {
    refreshControl.tintColor = .blue
    refreshControl.attributedTitle = NSAttributedString(string: "Fetching github repos", attributes: [NSAttributedString.Key.foregroundColor: UIColor.blue])
    refreshControl.addTarget(self, action: #selector(fetchRepositories), for: .valueChanged)
  }

 @objc private func fetchRepositories(){
    NetworkManager.shared.downloadTrendingRepo { [weak self] reposArray in
      self?.dataSource.onNext(reposArray)
      self?.refreshControl.endRefreshing()
    }
  }

}

//extension TrendingFeedVC: UITableViewDelegate, UITableViewDataSource {
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    repositories.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: VACardCell.identifier, for: indexPath) as? VACardCell else {return UITableViewCell()}
//
//    cell.configureCell(repository: repositories[indexPath.row])
//
//    return cell
//  }
//
//  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//      // Return the desired height for spacing between cells
//      return 10 // Adjust this height as needed
//  }
//
//  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//      // Return a clear view to create spacing
//      return UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 50))
//  }
//
//}

#Preview {
  TrendingFeedVC()
}
