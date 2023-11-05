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
                Image(systemName: isRunning ? "pause.circle" : "play.circle")
                    .resizable()
                    .frame(width: 200, height: 200)
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
     var goalTime = DateComponents(minute:3)
    
    let startDate = Date.now
    
    @State private var step = 1.0
    @State var goal: Double
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View
    {
        ZStack
        {
            Circle()
                .stroke(Color.green, lineWidth: 25)
                .frame(width:200, height: 200)
            
            Circle()
                .trim(from:0, to: progress())
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 25,
                        lineCap: .round,
                        lineJoin:.round
                    )
                )
                .foregroundColor(
                    (completed() ? Color.orange : Color.red)
                ).animation(
                    .easeInOut(duration: 0.2)
                )
                .frame(width: 200, height: 200)
             
//            Clock(counter: step, countTo: goal)
//            Text(Calendar.current.date(byAdding: goalTime, to: .now+1)!, style: .timer)
            Text(timerInterval: startDate...startDate + goal)
                .font(.system(size: 40))
                .fontWeight(.black)

        }
        .onReceive(timer) { time in
            if (self.step < self.goal) {
                self.step += 1
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }

    func progress() -> CGFloat {
        return (CGFloat(step) / CGFloat(goal))
    }
}

#Preview("ProgressCircle") {
    ProgressCircle(goal: 120.0)
}

struct ShitProgressCircle: View
{
    @State private var step = 1.0
    @State private var goal = 120.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View 
    {
        ZStack
        {
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle().stroke(Color.green, lineWidth: 25)
            )
             
            Circle()
                .fill(Color.clear)
                .frame(width: 250, height: 250)
                .overlay(
                    Circle().trim(from:0, to: progress())
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: 25,
                                lineCap: .round,
                                lineJoin:.round
                            )
                        )
                        .foregroundColor(
                            (completed() ? Color.orange : Color.red)
                        ).animation(
                            .easeInOut(duration: 0.2)
                        )
                )
             
            Clock(counter: step, countTo: goal)
        }.onReceive(timer) { time in
            if (self.step < self.goal) {
                self.step += 1
            }
        }
    }
    
    func completed() -> Bool {
        return progress() == 1
    }

    func progress() -> CGFloat {
        return (CGFloat(step) / CGFloat(goal))
    }
}
 
struct Clock: View {
    var counter: Double = 1.0
    var countTo: Double
     
    var body: some View {
        VStack {
            Text(counterToMinutes())
                .font(.system(size: 60))
                .fontWeight(.black)
        }
    }

    func counterToMinutes() -> String {
        let currentTime = countTo - counter
        let seconds = currentTime.truncatingRemainder(dividingBy: 60.0)
        let minutes = Int(currentTime / 60)
                 
        
//        let duration = TimeInterval(currentTime)
//        return tmv.formatted()
        
        return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
    }
}

#Preview("ShitProgressCircle") {
    ShitProgressCircle()
}

