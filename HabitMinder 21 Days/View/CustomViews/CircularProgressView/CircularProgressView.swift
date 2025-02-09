//
//  CircularProgressView.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/9/24.
//

import UIKit

final class CircularProgressView: UIView {
    
    private let progressLayer = CAShapeLayer()
    private let trackLayer = CAShapeLayer()
    private var lineWidth: CGFloat
    private var progressColor: UIColor
    private var trackColor: UIColor
    
    init(progressColor: UIColor = .accentColor, trackColor: UIColor = .secondaryColor, lineWidth: CGFloat = 7.0) {
        self.lineWidth = lineWidth
        self.progressColor = progressColor
        self.trackColor = trackColor
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
#if DEBUG
        fatalError("init(coder:) has not been implemented")
#else
        super.init(coder: coder)
#endif
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCircularPath()
    }
    
    private func setupViews() {
        backgroundColor = .clear
        configureLayer(layer: trackLayer, color: trackColor, lineWidth: lineWidth)
        configureLayer(layer: progressLayer, color: progressColor, lineWidth: lineWidth)
        layer.addSublayer(trackLayer)
        layer.addSublayer(progressLayer)
    }
    
    private func updateCircularPath() {
        layer.cornerRadius = frame.size.width / 2
        let circularPath = createCircularPath()
        trackLayer.path = circularPath
        progressLayer.path = circularPath
    }
    
    private func createCircularPath() -> CGPath {
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = (frame.size.width - 1.5) / 2
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true).cgPath
    }
    
    private func configureLayer(layer: CAShapeLayer, color: UIColor, lineWidth: CGFloat) {
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color.cgColor
        layer.lineWidth = lineWidth
    }
    
    func setProgressWithAnimation(to value: Float, duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: CircularAnimationKeys.strokeEnd)
        animation.toValue = value
        animation.duration = duration
        animation.fromValue = progressLayer.strokeEnd
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        progressLayer.strokeEnd = CGFloat(value)
        progressLayer.add(animation, forKey: CircularAnimationKeys.progressAnimation)
    }
}
