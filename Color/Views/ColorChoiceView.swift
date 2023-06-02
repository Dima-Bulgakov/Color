//
//  ColorChoiceView.swift
//  Color
//
//  Created by Dima on 01.06.2023.
//

import UIKit

final class ColorChoiceView: UIView {

    // MARK: - Properties
    private var verticalStackArray: [Any] = []
    
    var redSlider = UISlider()
    var greenSlider = UISlider()
    var blueSlider = UISlider()
    
    var redLabel = UILabel()
    var greenLabel = UILabel()
    var blueLabel = UILabel()
    
    var numRedLabel = UILabel()
    var numGreenLabel = UILabel()
    var numBlueLabel = UILabel()
    
    let resultColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let addColorButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor =  #colorLiteral(red: 0.192312386, green: 0.1262226701, blue: 0.1454250515, alpha: 1)
        button.setTitle("Add Color", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let horizontStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        mainConfig()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    private func mainConfig() {
        backgroundColor = .white
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 10, height: 10)
        layer.shadowRadius = 20
    }
    
    private func createLabel(text: String, position: NSTextAlignment) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textAlignment = position
        return label
    }
    
    private func createSlider(maxValue: Float, trackColor: UIColor, thumbColor: UIColor) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = maxValue
        slider.minimumTrackTintColor = trackColor
        slider.maximumTrackTintColor = UIColor.systemGray5
        slider.thumbTintColor = thumbColor
        slider.value = 100
        return slider
    }
    
    private func createHorizontalStack(_ labels: [UILabel]) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        labels.forEach { stack.addArrangedSubview($0) }
        verticalStackArray.append(stack)
        return stack
    }
    
    private func addViews() {
        redSlider = createSlider(maxValue: 255, trackColor: .systemRed, thumbColor: .systemRed)
        greenSlider = createSlider(maxValue: 255, trackColor: .systemGreen, thumbColor: .systemGreen)
        blueSlider = createSlider(maxValue: 255, trackColor: .systemBlue, thumbColor: .systemBlue)
        
        redLabel = createLabel(text: "Red", position: .left)
        greenLabel = createLabel(text: "Green", position: .left)
        blueLabel = createLabel(text: "Blue", position: .left)
        
        numRedLabel = createLabel(text: String(format: "%.0f", redSlider.value), position: .right)
        numGreenLabel = createLabel(text: String(format: "%.0f", greenSlider.value), position: .right)
        numBlueLabel = createLabel(text: String(format: "%.0f", blueSlider.value), position: .right)
        
        let redStack = createHorizontalStack([redLabel, numRedLabel])
        let greenStack = createHorizontalStack([greenLabel, numGreenLabel])
        let blueStack = createHorizontalStack([blueLabel, numBlueLabel])
        
        [resultColorView,
         redStack,
         redSlider,
         greenStack,
         greenSlider,
         blueStack,
         blueSlider,
         addColorButton
        ].forEach { item in
            verticalStackArray.append(item)
        }
        
        verticalStackArray.forEach { verticalStack.addArrangedSubview($0 as! UIView) }
        
        addMySubview(verticalStack)
    }
}

// MARK: - Extension
private extension ColorChoiceView {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
        ])
    }
}
