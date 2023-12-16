//
//  GameOverview.swift
//  GamePriest
//
//  Created by Maria Concetta on 12/12/23.
//

import SwiftUI

class GameOverView: UIView {
    
    var onRestart: (() -> Void)?
    var onQuit: (() -> Void)?
    
    var gameScene: GameScene?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGameOverview()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupGameOverview()
    }

    private func setupGameOverview() {
        // Imposta uno sfondo con un colore più visibile
        backgroundColor = UIColor(red: 0.2, green: 0.5, blue: 0.2, alpha: 0.5)

        // Contenuto della schermata di GameOverview
        let imageView = UIImageView(image: UIImage(named: "BackGround2.png"))
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)

        let gameOverImage = UIImageView(image: UIImage(named: "GOver"))
        gameOverImage.contentMode = .scaleAspectFit
        addSubview(gameOverImage)
        

        let restartButton = UIButton(type: .system)
        restartButton.setTitle("Play again", for: .normal)
        restartButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        restartButton.setTitleColor(UIColor.white, for: .normal)
        restartButton.backgroundColor = UIColor.orange
        restartButton.layer.cornerRadius = 10
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        addSubview(restartButton)

        let quitButton = UIButton(type: .system)
        quitButton.setTitle("Exit", for: .normal)
        quitButton.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        quitButton.setTitleColor(UIColor.white, for: .normal)
        quitButton.backgroundColor = UIColor.orange
        quitButton.layer.cornerRadius = 10
        quitButton.addTarget(self, action: #selector(quitButtonTapped), for: .touchUpInside)
        addSubview(quitButton)

        // Layout degli elementi
        imageView.translatesAutoresizingMaskIntoConstraints = false
        gameOverImage.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        quitButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            gameOverImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameOverImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),

            restartButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            restartButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            restartButton.widthAnchor.constraint(equalToConstant: 255),
            restartButton.heightAnchor.constraint(equalToConstant: 80),

            quitButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            quitButton.topAnchor.constraint(equalTo: restartButton.bottomAnchor, constant: 20),
            quitButton.widthAnchor.constraint(equalToConstant: 255),
            quitButton.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    
    
    @objc private func restartButtonTapped() {
        onRestart?()
        //gameScene?.restartGame()
    
    }

    @objc private func quitButtonTapped() {
        onQuit?()
    }
    
}
