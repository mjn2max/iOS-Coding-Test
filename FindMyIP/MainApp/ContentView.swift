//
// ContentView.swift
// MainApp
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI
import IPFramework

struct ContentView: View {
    var body: some View {
        let viewModel = IPViewModel(service: IPService())
        MyIPView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
