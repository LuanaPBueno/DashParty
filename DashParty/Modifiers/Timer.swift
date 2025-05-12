//
//  Timer.swift
//  DashParty
//
//  Created by Maria Eduarda Mariano on 02/05/25.
//

import SwiftUI

struct TimerLabel: View {
    
    @State var timeRemaining: Int = 1
    let timer = Timer.publish(every: 1, on: .current, in: .common).autoconnect()
    
    var onFinished: () -> Void = { }

    
    var body: some View {
        Image("timer")
            .overlay{
                Text("\(timeRemaining)")
                    .font(.custom("TorukSC-Regular", size: 30))
                    .foregroundColor(.white)
                    .onReceive(timer) { _ in
                        if timeRemaining > 0 {
                            timeRemaining += 1
                        } else {
                            timer.upstream.connect().cancel()
                            onFinished()
                        }
                    }
            }
    }
}

#Preview {
    TimerLabel()
}
