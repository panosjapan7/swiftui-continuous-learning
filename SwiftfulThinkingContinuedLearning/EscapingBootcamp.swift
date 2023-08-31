//  EscapingBootcamp.swift

import SwiftUI

class EscapingViewModel: ObservableObject {
    @Published var text: String = "Hello"
    
    func getData() {
        //        downloadData3 { [weak self] returnedData in
        //            self?.text = returnedData
        //        }
        
//        downloadData4 { [weak self] returnedResult in
//            self?.text = returnedResult.data
//        }
        
        downloadData5 { [weak self] returnedResult in
            self?.text = returnedResult.data
        }

    }
    
    func downloadData() -> String {
        return "New data!"
    }
    /*
     Think about the '(_ data: String) -> Void)` as a separate function
     */
    func downloadData2(completionHandler: (_ data: String) -> Void) {
        completionHandler("New data2!")
    }
    
    // when we add the @escaping it makes our code asynchronous
    // meaning it's not going to execute and return immediately.
    func downloadData3(completionHandler: @escaping (_ data: String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completionHandler("New data3!")
        }
    }
    
    func downloadData4(completionHandler: @escaping (DownloadResult) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New data4!")
            completionHandler(result)
        }
    }
    
    func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let result = DownloadResult(data: "New data5!")
            completionHandler(result)
        }
    }
    
}

struct DownloadResult {
    let data: String
    
}

typealias DownloadCompletion = (DownloadResult) -> Void

struct EscapingBootcamp: View {
    
    @StateObject var vm = EscapingViewModel()
    
    var body: some View {
        Text(vm.text)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
    }
}

struct EscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        EscapingBootcamp()
    }
}
