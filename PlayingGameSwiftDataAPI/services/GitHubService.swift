import Foundation

class GitHubService {
    func fetchUser(userName: String, completion: @escaping ([String: Any]?) -> Void) {
        let urlString = "https://api.github.com/users/\(userName)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Erreur de chargement des données : \(error)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("Pas de données à retourner")
                completion(nil)
                return
            }

            do {
                // Convertit les données en dictionnaire JSON
                if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                    //print(jsonObject)
                    completion(jsonObject)
                } else {
                    print("Impossible de parser la réponse JSON")
                    completion(nil)
                }
            } catch {
                print("Erreur de parsing JSON : \(error)")
                completion(nil)
            }
        }.resume()
    }
}

