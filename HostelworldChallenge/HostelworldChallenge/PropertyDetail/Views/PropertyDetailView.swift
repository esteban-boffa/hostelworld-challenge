//
//  PropertyDetailView.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 07/03/2023.
//

import SwiftUI

struct PropertyDetailView: View, ViewControllableProtocol {

    typealias Constants = PropertyDetailViewModel.Constants

    // MARK: Properties

    @ObservedObject var viewModel: PropertyDetailViewModel

    // MARK: Body

    var body: some View {
        VStack {
            switch viewModel.state {
            case .success:
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image(uiImage: viewModel.propertyImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        VStack {
                            Text(viewModel.propertyName)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.top, 8)
                            Text(viewModel.address1)
                                .padding(.top, 8)
                            Text(viewModel.address2)
                                .padding(.top, 1)
                                .if(!viewModel.hasAddress2) { view in
                                    view
                                        .foregroundColor(.gray)
                                        .italic()
                                }
                            Text(viewModel.city)
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 1)
                            Text(viewModel.country)
                                .font(.callout)
                                .fontWeight(.bold)
                                .padding(.top, 1)
                            HStack {
                                Text(Constants.descriptionTitle)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 16)
                                Spacer()
                            }
                            Text(viewModel.description)
                                .padding(.top, 4)
                            HStack {
                                Text(Constants.directionsTitle)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 16)
                                Spacer()
                            }
                            Text(viewModel.directions)
                                .padding(.top, 4)
                        }
                        .padding([.leading, .trailing], 16)
                    }
                }
            case .error:
                Text(Constants.errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing], 16)
            case .loading:
                ProgressView()
                    .scaleEffect(2)
            }
        }
    }
}

struct PropertyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyDetailView(viewModel: PropertyDetailViewModel(id: ""))
    }
}
