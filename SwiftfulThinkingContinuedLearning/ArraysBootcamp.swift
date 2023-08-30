//  ArraysBootcamp.swift

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init(){
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // sort
        /*
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
            // shorthand version of the above
        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
         */
        
        // filter
        /*
//        filteredArray = dataArray.filter({ (user) -> Bool in
//            return user.points > 50
//            return user.isVerified
//            return user.name.contains("Pa")
//        })
        
        // shorthand of the above
        filteredArray = dataArray.filter({$0.isVerified})
         */
        
        // map
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name ?? "NO NAME"
//        })
        // shorthand of the above
//        mappedArray = dataArray.map({ $0.name })
        // Compact map
//        mappedArray = dataArray.compactMap({ (user) -> String? in
//                return user.name
//        })
        //shorthand of the above
        mappedArray = dataArray.compactMap({ $0.name })
         */
        
        // Chaining sort, filter and map methods
        mappedArray = dataArray
                        .sorted(by: {$0.points > $1.points})
                        .filter({$0.isVerified})
                        .compactMap({$0.name})
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Panos", points: 5, isVerified: true)
        let user2 = UserModel(name: "Nick", points: 0, isVerified: false)
        let user3 = UserModel(name: nil, points: 15, isVerified: true)
        let user4 = UserModel(name: "Joe", points: 2, isVerified: false)
        let user5 = UserModel(name: "Sam", points: 20, isVerified: true)
        let user6 = UserModel(name: "Walt", points: 19, isVerified: false)
        let user7 = UserModel(name: "Will", points: 55, isVerified: true)
        let user8 = UserModel(name: nil, points: 53, isVerified: false)
        let user9 = UserModel(name: "Jay", points: 37, isVerified: false)
        let user10 = UserModel(name: "Tuve", points: 1, isVerified: true)
        self.dataArray.append(contentsOf: [
        user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
                
//                ForEach(vm.filteredArray){ user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}
