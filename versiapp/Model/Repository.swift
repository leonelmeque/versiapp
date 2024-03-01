import Foundation

struct Repository: Decodable, Encodable {
  let name: String
  let repo_description: String
  let thumbnail: String
  let numberOfForks: String
  let language: String
  let contributors: String
  let repoURL: String
}
