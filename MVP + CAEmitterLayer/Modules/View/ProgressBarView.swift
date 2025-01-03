//
//  ProgressBarView.swift
//  MVP + CAEmitterLayer
//
//  Created by NikitaKorniuk   on 15.12.24.
//

import UIKit
import SnapKit

class ProgressBarView: UIView {
    //MARK: - Properties
    private let progressLayer: CALayer = {
        let element = CALayer()
        element.backgroundColor = UIColor.systemRed.cgColor
        element.cornerRadius = 6
        element.masksToBounds = true
        return element
    }()
    private let backgroundLayer: CALayer = {
        let element = CALayer()
        element.backgroundColor = UIColor.lightGray.cgColor
        element.cornerRadius = 6
        element.masksToBounds = true
        return element
    }()
    
    private var progress: CGFloat = 0 {
        didSet {
            updateProgressLayer()
        }
    }
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
    }
    //MARK: - Methods
    private func setupLayers() {
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(progressLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundLayer.frame = bounds
        updateProgressLayer()
    }
    
    private func updateProgressLayer() {
        let progressWidth = bounds.width * progress
        progressLayer.frame = CGRect(x: 0, y: 0, width: progressWidth, height: bounds.height)
    }
    
    private func setProgress(_ newProgress: CGFloat, animated: Bool, duration: TimeInterval = 0.25) {
        let clampedProgress = min(max(newProgress, 0), 1)
        if animated {
            let animation = CABasicAnimation(keyPath: "bounds.size.width")
            animation.fromValue = progressLayer.bounds.width
            animation.toValue = bounds.width * clampedProgress
            animation.duration = duration
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            progressLayer.add(animation, forKey: "progressAnimation")
        }
        progress = clampedProgress
    }
    
    func addProgress () {
        setProgress(progress + 0.1, animated: true)
    }
    
    func deleteProgress() {
        setProgress(progress - 0.1, animated: true)
    }
    
    func resetProgress() {
        setProgress(0, animated: true)
    }
}
