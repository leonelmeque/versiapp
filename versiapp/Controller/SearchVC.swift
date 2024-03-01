import UIKit
import RxSwift
import RxCocoa

class SearchVC: UIViewController, UITableViewDelegate, UITextFieldDelegate {

  var tableView: UITableView!
  let vaRoundedBorderTextField = VARoundedBorderTextField()
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
      super.viewDidLoad()
      configure()
      configureTableView()
      setupLayout()
      configureTextField()
      tableView.rx.setDelegate(self).disposed(by: disposeBag)
    
  }
  
  private func configure(){
    self.view.backgroundColor = .systemBackground
    self.view.addSubview(vaRoundedBorderTextField)

  }

  private func configureTextField(){
    let searchResultsObservable = vaRoundedBorderTextField.rx.text.orEmpty
      .map { value in
      value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
      }
      .debounce(.seconds(2), scheduler: MainScheduler.instance)
      .flatMap { (query: String?) -> Observable<[Repository]> in
          guard let query = query, !query.isEmpty else { return Observable<[Repository]>.just([]) }

          guard let url = URL(string: searchURL + query + starsDescendingSegment) else { return Observable<[Repository]>.just([]) }



          return URLSession.shared.rx.json(url: url).map {
            let result = $0 as AnyObject
            let items = result.object(forKey: "items") as? [[String: Any]] ?? []
            var searchRepos = [Repository]()


            for item in items {

              let name = item["name"] as? String,
              description = item["description"] as? String,
              numberOfForks = item["forks_count"] as? String,
              language = item["language"] as? String,
              repoURL = item["html_url"] as? String

              let newRepo = Repository(name: name ?? "", repo_description: description ?? "" , thumbnail: "" , numberOfForks: numberOfForks ?? "", language: language ?? "", contributors: "123", repoURL: repoURL ?? "")

              searchRepos.append(newRepo)
          }

            print(searchRepos.count)

          return searchRepos
       }
    }
    .observe(on: MainScheduler.instance)

    searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: VACardCell.identifier)) {(row, repo: Repository, cell: VACardCell) in
      cell.configureCell(repository: repo)
    }
    .disposed(by: disposeBag)

  }

  private func configureTableView(){
    tableView = UITableView()
    tableView.separatorColor = .none
    tableView.register(VACardCell.self, forCellReuseIdentifier: VACardCell.identifier)

    self.view.addSubview(tableView)
  }

  private func setupLayout(){
    var constraints: [NSLayoutConstraint] = []

    tableView.translatesAutoresizingMaskIntoConstraints = false
    vaRoundedBorderTextField.translatesAutoresizingMaskIntoConstraints = false

    constraints += [
      vaRoundedBorderTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
      vaRoundedBorderTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
      vaRoundedBorderTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
    ]
    
    constraints += [
      tableView.topAnchor.constraint(equalTo: vaRoundedBorderTextField.bottomAnchor, constant: 16),
      tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
      tableView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor)
    ]

    NSLayoutConstraint.activate(constraints)
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) as? VACardCell else {return}
    self.presentSFSafariVCFor(url: cell.repo.repoURL)
  }

  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    self.view.endEditing(true)
  }

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    self.view.endEditing(true)
    return true
  }

}


#Preview {
  SearchVC()
}
