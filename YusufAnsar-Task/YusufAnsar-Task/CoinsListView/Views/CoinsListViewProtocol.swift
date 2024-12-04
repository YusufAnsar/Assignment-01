//
//  CoinsListViewProtocol.swift
//  YusufAnsar-Task
//
//  Created by Yusuf Ansar  on 05/12/24.
//


import Foundation

protocol CoinsListViewProtocol: AnyObject {
    func showErrorAlert(title: String, message: String)
    func showScreenLoader()
    func hideScreenLoader()
    func refreshScreen()
    func reloadScreen()
}