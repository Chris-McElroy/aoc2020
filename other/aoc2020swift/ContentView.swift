//
//  ContentView.swift
//  aoc2020
//
//  Created by 4 on 12/15/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Done!")
            .padding()
            .onAppear { day24() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
