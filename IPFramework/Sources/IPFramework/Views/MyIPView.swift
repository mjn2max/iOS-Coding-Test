//
// MyIPView.swift
// FindMyIP
//
// Created by Huy D. on 12/3/23
// mjn2max.github.io 😜
// 
// Copyright © 2023. All rights reserved.
// ___ORGANIZATIONNAME___
//

import SwiftUI

public struct MyIPView: View {
    @ObservedObject var viewModel: IPViewModel
    
    public init(viewModel: IPViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            switch viewModel.pageState {
            case .idle:
                Text("App doesn't fetching the data yet!")
            case .loading:
                ProgressView {
                    Text("Loading Data...")
                }
            case .failed:
                Text("App failed to fetch data! Please try again")
            case .success:
                if let ipData = viewModel.ipData {
                    Item(keyString: "IP", valueString: ipData.ip)
                    Item(keyString: "Version", valueString: ipData.version)
                    Item(keyString: "City", valueString: ipData.city)
                    Item(keyString: "Region", valueString: ipData.region)
                    Item(keyString: "Country Name", valueString: ipData.countryName)
                } else {
                    Text("Data is nil")
                }
            }
        }
        .onAppear {
            viewModel.fetchingData()
        }
    }
}

extension MyIPView {
    @ViewBuilder
    func Item(keyString: String, valueString: String) -> some View {
        HStack(content: {
            Text(keyString)
                .font(.title3)
            Spacer()
            Text(valueString)
                .font(.callout)
        })
        .padding(.horizontal, 35)
        .padding(.vertical)
    }
}

#Preview("Idle") {
    let viewModel = IPViewModel()
    return MyIPView(viewModel: viewModel)
}

#Preview("Loading") {
    let viewModel = IPViewModel()
    viewModel.pageState = .loading
    return MyIPView(viewModel: viewModel)
}

#Preview("Failed") {
    let service = MockFailedService()
    let viewModel = IPViewModel(service: service)
    return MyIPView(viewModel: viewModel)
}

#Preview("Success") {
    let service = MockSuccessService()
    let viewModel = IPViewModel(service: service)
    return MyIPView(viewModel: viewModel)
}
