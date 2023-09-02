//  AccessibilityTextBootcamp.swift

import SwiftUI

struct AccessibilityTextBootcamp: View {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "heart.fill")
                                .font(.system(size: 30))
                            Text("Welcome to my app!")
                        }
                        .font(.title)
                        
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                        // this will scale down a maximum of 50% of its original size
                        // to fit in the lineLimit of 3 lines
//                            .minimumScaleFactor(0.7)
                            .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                    }
//                    .frame(height: 100)
                    .background(Color.red)
                    
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Hello, World")
        }
    }
}

extension ContentSizeCategory {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
            
        case .large, .extraLarge, .extraExtraLarge:
            return 0.8
        
        default:
            return 0.6
        }
    }
}

struct AccessibilityTextBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AccessibilityTextBootcamp()
    }
}
