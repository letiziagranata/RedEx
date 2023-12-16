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
        
        backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 0.9)
        
        // Aggiungi un pulsante Resume personalizzato
        resumeButton = UIButton(type: .system)
        resumeButton.setTitle("Resume", for: .normal)
        resumeButton.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18.0, weight:.bold)
        resumeButton.setTitleColor(UIColor.white, for: .normal)
        resumeButton.backgroundColor = UIColor(red: 1.0, green: 0.5, blue: 0.3, alpha: 1.0)
        resumeButton.layer.cornerRadius = 8.0
        resumeButton.addTarget(self, action: #selector(resumeButtonTapped), for: .touchUpInside)
        
        addSubview(resumeButton)
        
        // Layout del pulsante Resume
        resumeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resumeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            resumeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            resumeButton.widthAnchor.constraint(equalToConstant: 160.0), // Nuova larghezza
            resumeButton.heightAnchor.constraint(equalToConstant: 60.0)   // Nuova altezza
        ])
        
        //BOTTONE EXIT
        let QuitButton = UIButton(type: .system)
        QuitButton.setTitle("Quit", for: .normal)
        QuitButton.titleLabel?.font = UIFont.monospacedSystemFont(ofSize: 18.0, weight:.bold)
        QuitButton.setTitleColor(UIColor.white, for: .normal)
        QuitButton.backgroundColor = UIColor(red: 1.8, green: 0.5, blue: 0.3, alpha: 1.0)
        QuitButton.layer.cornerRadius = 8.0
        QuitButton.addTarget(self, action: #selector(QuitButtonTapped), for: .touchUpInside)
        
        addSubview(QuitButton)
        
        // Posiziona il nuovo pulsante
        QuitButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            QuitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            QuitButton.topAnchor.constraint(equalTo: resumeButton.bottomAnchor, constant: 20.0), // Spostamento verso il basso
            QuitButton.widthAnchor.constraint(equalToConstant: 160.0),
            QuitButton.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
        
        
    }
    
    @objc private func resumeButtonTapped() {
        removeFromSuperview()
        
        onResume?()
    }
    
    
    @objc private func QuitButtonTapped() {
        
        
    }
    
    
}

