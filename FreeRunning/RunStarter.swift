//
//  RunStarter.swift
//  FreeRunning
//
//  Created by Naziyok, Tolga on 29.10.23.
//

import SwiftUI

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

extension View
{
    
}

#Preview {
    RunStarter()
}
