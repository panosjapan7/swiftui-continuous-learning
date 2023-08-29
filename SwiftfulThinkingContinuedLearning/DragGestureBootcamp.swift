//  DragGestureBootcamp.swift

import SwiftUI

struct DragGestureBootcamp: View {
    
    // .zero is equal to CGSize(width: 0, height: 0)
    @State var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("\(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged{value in
                            withAnimation(.spring()){
                                offset = value.translation
                            }
                        }
                        .onEnded{ value in
                            withAnimation(.spring()){
                                offset = .zero
                            }
                        }
            )
        }
    }
    
    func getScaleAmount() -> CGFloat {
        // We divide by 2 our card starts from the middle
        // and we can go half of the screen to the left or half to the right.
        // So this is the max amount we can go to the left or right.
        let max = UIScreen.main.bounds.width / 2
        // absolute value; we're going to get a positive value whether we're moving it to the left or right.
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        // the percentage will get up to 100%; the min to 0.5; it will stop scaling once it gets to 0.5.
        // The "* 0.5" will slow down the rate of resizing by 50%
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    
    func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        
        // we won't use the abs bc if we're going to the left we want to rotate to the left, and if to the right, rotate to the right.
        let currentAmount = offset.width
        
        let percentage = currentAmount / max
        
        // converts the CGFloat to a Double
        let percentageAsDouble = Double(percentage)
        
        let maxAngle: Double = 10
        
        // if we're 100% to the edge it will rotate by 10
        // if we're 50% to the edge it will rotate by 5
        return percentageAsDouble * maxAngle
        
    }
}

struct DragGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureBootcamp()
    }
}
