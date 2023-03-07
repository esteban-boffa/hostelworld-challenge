//
//  TableView.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation
import SwiftUI

struct TableView: UIViewRepresentable {

    // MARK: Properties

    @ObservedObject var viewModel: HomeViewModel

    // MARK: Init

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }

    // MARK: UIViewRepresentable

    func makeUIView(context: UIViewRepresentableContext<TableView>) -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PropertyTableViewCell.self, forCellReuseIdentifier: PropertyTableViewCell.cellIdentifier)
        tableView.delegate = context.coordinator
        tableView.dataSource = context.coordinator
        return tableView
    }

    func updateUIView(_ uiView: UITableView, context: Context) {
        uiView.reloadData()
    }

    // MARK: Coordinator

    class Coordinator: NSObject, UITableViewDataSource, UITableViewDelegate {

        // MARK: Private Properties

        private var tableView: TableView

        // MARK: Init

        init(_ tableView: TableView) {
            self.tableView = tableView
        }

        // MARK: UITableViewDelegate & UITableViewDataSource

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            self.tableView.viewModel.getNumberOfRowsInSection()
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if let rowCell = tableView.dequeueReusableCell(withIdentifier: PropertyTableViewCell.cellIdentifier, for: indexPath) as? PropertyTableViewCell {
                let data = self.tableView.viewModel.dataForCellAt(indexPath: indexPath)
                rowCell.setupCell(data!)
                return rowCell
            }
            return UITableViewCell()
        }

        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: false)
            self.tableView.viewModel.fetchPropertyDetail(for: indexPath)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
