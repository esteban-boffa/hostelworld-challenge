//
//  HomeView.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import SwiftUI

struct HomeView: View, ViewControllableProtocol {

    // MARK: Properties

    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var viewModel: HomeViewModel

    // MARK: Body

    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .frame(height: 8)
                // SwiftUI list is not used since it allows a maximum number of 10 items
                // Furthermore the UITableView allows us to reuse cells
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
