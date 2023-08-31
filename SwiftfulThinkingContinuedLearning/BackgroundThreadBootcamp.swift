//  BackgroundThreadBootcamp.swift

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        // when we call the async on global, the code inside the brackets will run on a background thread.
//        DispatchQueue.global().async {
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()
            
            // Check whether or not we are on the Main Thread
            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 2: \(Thread.current)")
            
            // Offloads the task back onto the main Thread
            DispatchQueue.main.async {
                self.dataArray = newData
                
                // Check whether or not we are on the Main Thread
                print("CHECK 1: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }
            
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        
        return data
    }
}

struct BackgroundThreadBootcamp: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}
