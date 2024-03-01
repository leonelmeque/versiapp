import Foundation
import Alamofire

// Download Service
extension NetworkManager {
  func downloadTrendingReposDicArray(completion: @escaping (_ repos: [Dictionary<String, Any>]) -> Void)  {
    AF.request(trendingURL).responseData { response in
      var arrayWithData = [[String: Any]]()

      switch response.result {
      case .success(let value):
        guard let json = try? JSONSerialization.jsonObject(with: value, options: []) as? Dictionary<String, Any>,
              let jsonData = json["items"] as? [Dictionary<String, Any>]

        else {
          print("Failed to load data")
          return
        }

        for index in 0...10 {
          arrayWithData.append(jsonData[index])
        }

        completion(arrayWithData)

      case .failure(let error):
        print("An error has occured \(error)")

      }
    }
  }

  func downloadTrendingRepo(completion: @escaping (_ reposArray: [Repository])-> Void) {
    var trendingRepos = [Repository]()

    downloadTrendingReposDicArray { repos in
      for repo in repos {
        let avatarURL = repo["avatar_url"] as? String
        let name = repo["name"] as? String
        let description = repo["description"] as? String
        let numberOfForks = repo["forks_count"] as? String
        let language = repo["language"] as? String
        let repoURL = repo["html_url"] as? String

        let newRepo = Repository(name: name ?? "", repo_description: description ?? "", thumbnail: avatarURL ?? "", numberOfForks: numberOfForks ?? "", language: language ?? "", contributors: "123", repoURL: repoURL ?? "")

        trendingRepos.append(newRepo)
      }

      completion(trendingRepos)
    }


  }
}

