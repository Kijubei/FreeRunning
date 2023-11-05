//
//  RunStarter.swift
//  FreeRunning
//
//  Created by Naziyok, Tolga on 29.10.23.
//

import SwiftUI
import Combine

struct RunStarter: View 
{
    @State var isRunning: Bool = false
    
    var body: some View
    {
        VStack
        {
            Spacer()
            Text("Start your Run")
                .foregroundStyle(.text)
            Button(action: buttonTapped)
            {
                    if isRunning
                    {
                        ZStack(alignment: .bottom)
                        {
                            ProgressCircle(goal: 120.0)
                            
                            Image(systemName: "pause")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .padding(20)
                        }
                    }
                    else
                    {
                        Image(systemName: "play.circle")
                            .resizable()
                            .frame(width: 200, height: 200)
                    }
            }
            Text("--:--:--")
                .font(.largeTitle)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    func buttonTapped()
    {
        withAnimation(.smooth)
        {
            isRunning.toggle()
        }
    }
}

#Preview("RunStarter") {
    RunStarter()
}

struct ProgressCircle: View
{
    let startDate = Date.now
    
    @State private var currentProgress = 0.0
    @State var goal: Double
    
    let timer = Timer.publish(
        every: 0.1,
        on: .main,
        in: .common
    ).autoconnect()
    
    var body: some View
    {
        ZStack
        {
            Circle()
                .stroke(.accent, lineWidth: 17)
                .frame(width:183, height: 183)
            
            Circle()
                .trim(from:0, to: progress())
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 17,
                        lineCap: .round,
                        lineJoin:.round
                    )
                )
                .foregroundColor(Color.green)
                .animation(.easeInOut, value: currentProgress)
                .frame(width: 183, height: 183)

            Text(timerInterval: startDate...startDate + goal)
                .font(.system(size: 40))
                .fontWeight(.black)
        }
        .onReceive(timer) { time in
            if (self.currentProgress < self.goal) {
                self.currentProgress += 0.1
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }

    func progress() -> CGFloat {
        return (CGFloat(currentProgress) / CGFloat(goal))
    }
}

#Preview("ProgressCircle") {
    ProgressCircle(goal: 120.0)
}
