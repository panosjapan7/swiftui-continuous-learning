//  MultipleSheetsBootcamp.swift

import SwiftUI

// Three ways to show multiple sheets
/*
    1. use binding
    2. use multiple .sheets
    3. use $item
 */

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

struct MultipleSheetsBootcamp: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                         selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
        }
        .sheet(item: $selectedModel) { model in
            NextScreen(selectedModel: model)
        }
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title).font(.largeTitle)
    }
}

struct MultipleSheetsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSheetsBootcamp()
    }
}
