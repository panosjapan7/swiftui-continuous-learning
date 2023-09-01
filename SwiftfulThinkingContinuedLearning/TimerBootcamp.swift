//  TimerBootcamp.swift

import SwiftUI

struct TimerBootcamp: View {
    // Create publisher
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    // Current Time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        // formatter.dateStyle = .medium
//        formatter.timeStyle = .full
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
     */
    
    // Countdown to date
    /*
    @State var timeRemaining: String = ""
//    let futureDate: Date = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
//        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let remaining = Calendar.current.dateComponents([.minute, .second], from: Date(), to: futureDate)
//        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
//        timeRemaining = "\(hour):\(minute):\(second)"
        timeRemaining = "\(minute):\(second)"
    }
     */
    
    // Animation Counter
    @State var count: Int = 1
    
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
                    .ignoresSafeArea()
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
//            Text(timeRemaining)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0 )
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0 )
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0 )
//            }
//            .frame(width: 150)
//            .foregroundColor(.white)
            
            TabView(selection: $count, content: {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            })
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
        }
//        .onReceive(timer) { value in
//            currentDate = value
//        }
//        .onReceive(timer) { _ in
//            if count <= 1 {
//                finishedText = "Wow!"
//            }
//            else {
//                count -= 1
//            }
//        }
//        .onReceive(timer) { _ in
//           updateTimeRemaining()
//        }
//        .onReceive(timer) { _ in
//            withAnimation(.easeInOut(duration: 0.5)){
//                count = count == 3 ? 0 : count + 1
//            }
//        }
        // Subscribe to publisher & perform an action
        .onReceive(timer) { _ in
            withAnimation(.default){
                count = count == 5 ? 1 : count + 1
            }
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
