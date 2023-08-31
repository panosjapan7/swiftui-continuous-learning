//  DownloadWithEscapingBootcamp.swift

import SwiftUI

//struct PostModel: Identifiable, Codable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts:[PostModel] = []
    
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadDate(fromURL: url) { returnedData in
            if let data = returnedData{
                // Now that we made all those checks and know we have good data...
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                
                // This task will render the newPost onto the UI which means
                // we must make it happen on the Main thread, not background thread
                DispatchQueue.main.async { [weak self] in
//                    self?.posts.append(newPost)
                    self?.posts = newPosts
                }
            } else {
                print("No data returned")
            }
        }
        
        /*
         
        // The dataTask happens on a background thread automatically
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            /*
            // make sure we got data
            guard let data = data else {
                print("NO DATA")
                return
            }
            
            // make sure we didn't get an error
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            // make sure we gat a response
            guard let response = response as? HTTPURLResponse else {
                print("Invalid response.")
                return
            }
            
            // make sure the response is a good response (not 400 or 500 etc)
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but is \(response.statusCode)")
                return
            }
             */
            
            // Combine the above guard checks into one guard
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                return
            }
                
            
            
            // Now that we made all those checks and know we have good data...
//            print("SUCCESSFULLY DOWNLOAD DATA")
//            print(data)
//            let jsonString = String(data: data, encoding: .utf8)
//            print(jsonString)
            
            guard let newPost = try? JSONDecoder().decode(PostModel.self, from: data) else { return }
            
            // This task will render the newPost onto the UI which means
            // we must make it happen on the Main thread, not background thread
            DispatchQueue.main.async { [weak self] in
                self?.posts.append(newPost)
            }
            
            
        }.resume()
         */
    }
    
    func downloadDate(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // Combine the above guard checks into one guard
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil)
                return
            }
            
            completionHandler(data)
            
        }.resume()
    }
    
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {post in
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
