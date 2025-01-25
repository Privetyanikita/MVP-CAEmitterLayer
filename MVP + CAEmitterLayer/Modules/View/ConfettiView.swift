//
//  ConfettiView.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 12.01.25.
//

import UIKit

final class ConfettiView: UIView {

    private let dimension = 4
    private var velocities = [50, 100, 150, 200]
    private var emojis = ["🎉", "✨", "🎈", "🍀"]

    private let rootLayer = CALayer()
    private let confettiEmitterLayer = CAEmitterLayer()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        layer.addSublayer(rootLayer)

        setupRootLayer()
        setupConfettiEmitterLayer()

        confettiEmitterLayer.emitterCells = generateConfettiEmitterCells()
        rootLayer.addSublayer(confettiEmitterLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        confettiEmitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: 0)
        confettiEmitterLayer.emitterSize = CGSize(width: bounds.width, height: 1)
    }

    // MARK: - Setup Layers
    private func setupRootLayer() {
        rootLayer.backgroundColor = UIColor.clear.cgColor
    }

    private func setupConfettiEmitterLayer() {
        confettiEmitterLayer.emitterShape = .line
        confettiEmitterLayer.birthRate = 0
    }

    // MARK: - Generator
    private func generateConfettiEmitterCells() -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()

        for index in 0..<emojis.count {
            let cell = CAEmitterCell()
            cell.contents = generateEmojiImage(emoji: emojis[index])?.cgImage
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.scale = 0.2
            cell.scaleRange = 0.1
            cell.velocity = CGFloat(randomVelocity)
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi / 4
            cell.spin = 3.5
            cell.spinRange = 1

            cells.append(cell)
        }

        return cells
    }

    // MARK: - Helpers
    private var randomNumber: Int {
        return Int(arc4random_uniform(UInt32(dimension)))
    }

    private var randomVelocity: Int {
        return velocities[randomNumber]
    }

    private func generateEmojiImage(emoji: String) -> UIImage? {
        let size = CGSize(width: 35, height: 35)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28)]
        let string = NSAttributedString(string: emoji, attributes: attributes)
        string.draw(in: CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    // MARK: - Public Methods
    func startConfetti(duration: TimeInterval = 3.0) {
        confettiEmitterLayer.birthRate = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak self] in
            self?.stopConfetti()
        }
    }

    func stopConfetti() {
        confettiEmitterLayer.birthRate = 0.0
    }

    // MARK: - Touch Handling
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
}
