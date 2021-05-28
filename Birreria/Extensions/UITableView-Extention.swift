//
//  UITableView-Extention.swift
//  Birreria
//
//  Created by Ossama Abdelwahab on 26/05/21.
//

import UIKit

extension UITableView{
    func updateEmptyState(rowsCount: Int, emptyMessage: String){
        rowsCount == 0 ? showEmptyState(emptyMessage) : hideEmptyState()
    }
    
    private func showEmptyState(_ message: String){
        let label = UILabel(frame: .zero)
        label.text = message
        label.textAlignment = .center
        
        label.font = regular(Config.headline)
        label.textColor = Config.orange
        
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        let containerView = UIView(frame: self.frame)
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor, constant: -100)
        ])
        
        backgroundView = containerView
    }
    
    private func hideEmptyState(){
        backgroundView = nil
    }
    
}
