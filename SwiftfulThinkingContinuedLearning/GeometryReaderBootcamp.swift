//  GeometryReaderBootcamp.swift

import SwiftUI

struct GeometryReaderBootcamp: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(Angle(degrees: getPercentage(geo: geometry) * 30),
                                              axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                    
                }
            }
        }
        
        
//        GeometryReader { geometry in
//            HStack(spacing: 0) {
//                Rectangle().fill(Color.red)
//                    .frame(width: geometry.size.width * 0.6666)
//
//                Rectangle().fill(Color.blue)
//            }
//            .ignoresSafeArea()
//        }
        
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        // we get the center of the screen
        let maxDistance = UIScreen.main.bounds.width / 2
        
        // we get the middle x coordinate (the center of the rectangle)
        let currentX = geo.frame(in: .global).midX
        
        return Double(1 - (currentX / maxDistance))
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}
