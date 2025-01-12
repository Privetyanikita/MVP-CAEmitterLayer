//
//  ConfettiView.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 12.01.25.
//

import UIKit

class ConfettiView: UIView {

    private let dimension = 4
    private var velocities = [50, 100, 150, 200]
    private var imageNames = ["box", "circle", "spiral", "triangle"]
    private var colors: [UIColor] = [.red, .green, .blue, .magenta]

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

    // MARK: - Setup Layers
    private func setupRootLayer() {
        rootLayer.backgroundColor = UIColor.clear.cgColor
    }

    private func setupConfettiEmitterLayer() {
        confettiEmitterLayer.emitterSize = CGSize(width: bounds.width, height: 2) // Эмиттер по всей ширине экрана
        confettiEmitterLayer.emitterShape = .line // Частицы генерируются из линии
        confettiEmitterLayer.emitterPosition = CGPoint(x: bounds.width, y: 0) // Верхняя центральная часть экрана
        confettiEmitterLayer.birthRate = 0
    }

    // MARK: - Generator
    private func generateConfettiEmitterCells() -> [CAEmitterCell] {
        var cells = [CAEmitterCell]()

        for index in 0..<10 {
            let cell = CAEmitterCell()
            cell.color = nextColor(i: index)
            cell.contents = UIImage(systemName: "star.fill")?.cgImage
            cell.birthRate = 4.0
            cell.lifetime = 14.0
            cell.lifetimeRange = 0
            cell.scale = 0.1
            cell.scaleRange = 0.25
            cell.velocity = CGFloat(randomVelocity)
            cell.velocityRange = 50 // Небольшой разброс скорости
            cell.emissionLongitude = CGFloat.pi // Направление вниз
            cell.emissionRange = CGFloat.pi / 4 // Разброс угла движения частиц
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

    private func nextColor(i: Int) -> CGColor {
        return colors[i % dimension].cgColor
    }

    private func nextImage(i: Int) -> CGImage? {
        guard let image = UIImage(named: imageNames[i % dimension]) else {
            return nil
        }
        return image.cgImage
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
