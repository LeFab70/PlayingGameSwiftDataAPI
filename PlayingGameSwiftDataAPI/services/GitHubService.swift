import Foundation

class GitHubService {
    func fetchUser(userName: String, completion: @escaping ([String: Any]?) -> Void) {
        let urlString = "https://api.github.com/users/\(userName)"
        guard let url = URL(string: urlString) else {
            //completion(.failure(NSError(domain: "URL invalide", code: 0)))
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





//import Foundation

/*class GitHubService {
    func fetchUser(userName: String, completion: @escaping (Result<GitHubUser, Error>) -> Void) {
        let urlString = "https://api.github.com/users/\(userName)"
        guard let url = URL(string: urlString) else {
            //completion(.failure(NSError(domain: "URL invalide", code: 0)))
            completion(.failure(NSError(domain: "URL invalide", code: 0)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
               // print("Erreur de chargement des données : \(error)")
               completion(.failure(error))
                
                return
            }

            guard let data = data else {
                print("Pas de données à retourner")
                completion(.failure(NSError(domain: "Pas de données", code: 0)))
                return
            }

            do {
                // Convertit les données en dictionnaire JSON
                let jsonObject = try JSONSerialization.jsonObject(with: data)  //{
                    //print(jsonObject)
                    completion(.success(jsonObject as! GitHubUser))
               // } else {
                  //  print("Impossible de parser la réponse JSON")
                   // completion(.failure(NSError(domain: "Pas de données", code: 0)))
                //}
            } catch {
                print("Erreur de parsing JSON : \(error)")
               completion(.failure(error))
            }
        }.resume()
    }
}*/

