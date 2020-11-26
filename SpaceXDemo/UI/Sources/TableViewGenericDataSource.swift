//
//  TableViewGenericDataSource.swift
//  SpaceXDemo
//
//  Created by Yunus Emre Celebi on 25.11.2020.
//

import UIKit

protocol ConfigurableCell where Self: BaseTableViewCell {
    associatedtype DataType
    func configure(data: DataType)
}

class TableViewGenericDataSource<T, Cell>: NSObject, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate
where Cell: ConfigurableCell, T == Cell.DataType {

    var items: [T] = []

    var didSelectListener: ((T, IndexPath) -> Void)?
    var callbackPagination: (() -> Void)? = nil

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.generateReusableCell(Cell.self, indexPath: indexPath)
        cell.configure(data: items[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.didSelectListener?(items[indexPath.row], indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell.defaultHeight
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y

        if position > ((scrollView.contentSize.height - 100) - scrollView.frame.size.height) {
            self.callbackPagination?()
        }
    }
}
