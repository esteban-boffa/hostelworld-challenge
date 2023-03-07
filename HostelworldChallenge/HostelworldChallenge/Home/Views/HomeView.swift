//
//  HomeView.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import SwiftUI

struct HomeView: View, ViewControllableProtocol {

    // MARK: Properties

    @ObservedObject var viewModel: HomeViewModel

    // MARK: Body

    var body: some View {
        ZStack {
            VStack {
                Color.white
                    .frame(height: 8)
                TableView(viewModel: viewModel)
                    .padding([.leading, .trailing], 16)
            }
        }
        .overlay {
            ProgressView()
                .scaleEffect(2)
                .opacity(viewModel.showingProgressView ? 1 : 0)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
