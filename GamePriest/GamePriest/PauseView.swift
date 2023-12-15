//
//  PauseView.swift
//  GamePriest
//
//  Created by Maria Concetta on 15/12/23.
//

import SwiftUI

import UIKit

class PauseView: UIView {
 
    var resumeButton: UIButton!
    var onResume: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPauseView()    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupPauseView()
    }

    private func setupPauseView() {
            // Imposta uno sfondo con un colore più visibile
            backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 0.5)

            // Aggiungi un pulsante Resume personalizzato
            resumeButton = UIButton(type: .system)
            resumeButton.setTitle("Resume", for: .normal)
            resumeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
            resumeButton.setTitleColor(UIColor.white, for: .normal)
            resumeButton.backgroundColor = UIColor(red: 0.8, green: 0.2, blue: 0.2, alpha: 1.0)
            resumeButton.layer.cornerRadius = 8.0
            resumeButton.addTarget(self, action: #selector(resumeButtonTapped), for: .touchUpInside)

            addSubview(resumeButton)

            // Layout del pulsante Resume
            resumeButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                resumeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                resumeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                resumeButton.widthAnchor.constraint(equalToConstant: 120.0),
                resumeButton.heightAnchor.constraint(equalToConstant: 40.0)
            ])
        }

    @objc private func resumeButtonTapped() {
        removeFromSuperview()
        
        onResume?()
    }

    
}

