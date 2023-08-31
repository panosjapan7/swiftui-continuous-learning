//  DownloadWithCombine.swift

import SwiftUI

// 7. Cancel subscription if needed by calling 'store'
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    
    // 7. Cancel subscription if needed by calling 'store'
    // This is a var in which we'll store the publisher.
    // If we want to cancel the subscription we access this var and call cancel.
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        // the url needs to be https not http. Otherwise you'll get an error when you run the app.
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // Combine explanation:
        /*
            1. Let's say you sign up to a monthly subscription for a package
            2. The company would make the package behind the scenes (in a background thread)
            3. The company will ship the package & you'll receive it at your front door
            4. You'll check the box to make sure it's not damaged
            5. You'll open the package and make sure that it's not incorrect package
            6. You can now use the item in the package!
            7. The subscription is cancellable at any time
         */
        
        // 1. Create the publisher
            URLSession.shared.dataTaskPublisher(for: url)
        // 2. Subscribe publisher on a background thread
        // (it's done by default when using the dataTaskPublisher; we just do it for demo purposes)
            .subscribe(on: DispatchQueue.global(qos: .background))
        // 3. Receive the package on Main thread (bc we're going to use it in the UI)
            .receive(on: DispatchQueue.main)
        // 4. Make sure the box isn't package. We'll use tryMap (check that the data is good)
            // (tryMap is a map that can fail and throw an error)
            /*
            .tryMap { (data, response) -> Data in
                // a. check if this is an htttp response and a valid response
                guard let response = response as? HTTPURLResponse,
                // b. check status code of response
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
             */
            // We turned the above into a function
            .tryMap(handleOutput)
        
        //5. and make sure that it's not incorrect package (in our case, the data must contain an array of PostModel items)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
        
        // 6. Use the item in the package (use sink to put the fetched data into our app)
        /*
            .sink { (completion) in
                switch completion {
                case .finished:
                    print("COMPLETION: \(completion)")
                case .failure(let error):
                    print("There was an error: \(error)")
                }
                
            } receiveValue: { [weak self] (returnedPosts) in
                self?.posts = returnedPosts
            }
         */
        // We replace 6. with the code below:
        // If there's an error, replace it with hard-coded data (an empty array)
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
        
        // 7. Cancel subscription if needed by calling 'store'
        // Here we just store the publisher so we can cancel our subscription to it.
            .store(in: &cancellables)

    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
        // b. check status code of response
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) {post in
                VStack(alignment: .leading) {
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

struct DownloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombine()
    }
}
