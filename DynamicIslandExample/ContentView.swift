//
//  ContentView.swift
//  DynamicIslandExample
//
//  Created by Maksim Chizhavko on 11/24/22.
//

import SwiftUI
import ActivityKit

struct ContentView: View {
    
    @State
    private var activity: Activity<TimerAttributes>?
    
    var body: some View {
        VStack {
            VStack {
                Button {
                    startActivity()
                } label: {
                    Text("Start activity")
                }

                
                Button {
                    endActivity()
                } label: {
                    Text("End activity")
                }
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
    }
    
    func startActivity() {
        let attributes = TimerAttributes(timerName: "Dummy timer")
        let state = TimerAttributes.ContentState(date: Date())
       
        activity = try? Activity<TimerAttributes>.request(attributes: attributes, contentState: state)
    }
    
    func endActivity() {
        let state = TimerAttributes.ContentState(date: Date())
        
        Task {
            await activity?.end(using: state, dismissalPolicy: .immediate)
        }
    }
    
    func updateActivity() {
        let state = TimerAttributes.ContentState(date: Date())
        
        Task {
            await activity?.update(using: state)
        }
    }
}
