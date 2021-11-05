//
//  ViewController.swift
//  Run Animation
//
//  Created by Егор Астахов on 03.11.2021.
//

import UIKit
import Spring

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var springAnimationView: SpringView!
    
    @IBOutlet weak var presetTextLabel: UILabel!
    @IBOutlet weak var curveTextLabel: UILabel!
    @IBOutlet weak var forceTextLabel: UILabel!
    @IBOutlet weak var durationTextLabel: UILabel!
    @IBOutlet weak var delayTextLabel: UILabel!
    
    @IBOutlet weak var runCustomizeSpringButton: SpringButton!
    
    // MARK: - Properties
    var index: Int = 0 {
        didSet {
            if DataManagerClass.shared.animations.count == index {
                index = 0
            }
        }
    }
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // customize springAnimationView
        springAnimationView.layer.cornerRadius = 15
        // customize springButton
        runCustomizeSpringButton.layer.cornerRadius = 15
        runCustomizeSpringButton.setTitle("Run", for: .normal)
        // Устанавливаем изначальный текст, который будет во вью
        presetTextLabel.text = ""
        curveTextLabel.text = ""
        
        forceTextLabel.text = String(0.0)
        durationTextLabel.text = String(0.0)
        delayTextLabel.text = String(0.0)
        
    }
    
    // MARK: - Actions
    @IBAction func runAnimationSpringButton(_ sender: SpringButton) {
        
        // Передаем константам рандомные значения анимации
        let randomAnimation = DataManagerClass.shared.animations[index]
        let randomCurve = Spring.AnimationCurve.allCases.randomElement()
        
        let randomForce: Double = .random(in: 1...2)
        let randomDuration: Double = .random(in: 1...3)
        let randomDelay: Double = .random(in: 0.1...0.5)
        
        // Устанавливаем анимацию для вью
        springAnimationView.animation = randomAnimation.rawValue
        springAnimationView.curve = randomCurve?.rawValue ?? ""
        
        springAnimationView.force = randomForce
        springAnimationView.duration = randomDuration
        springAnimationView.delay = randomDelay
        // Устанавливаем анимацию для кнопки
        sender.animation = Spring.AnimationPreset.shake.rawValue
        sender.delay = 0.1
        sender.force = 0.2
        // Передаем значения в текст
        presetTextLabel.text = springAnimationView.animation
        curveTextLabel.text = springAnimationView.curve
        // Передаем значения с 3 значениями после точки
        forceTextLabel.text = String(format: "%.3f", springAnimationView.force)
        durationTextLabel.text = String(format: "%.3f", springAnimationView.duration)
        delayTextLabel.text = String(format: "%.3f", springAnimationView.delay)
        // Обновляем текст в кнопке
        while index != (DataManagerClass.shared.animations.count - 1) {
            runCustomizeSpringButton.setTitle("Run \(DataManagerClass.shared.animations[index + 1].rawValue)", for: .normal)
            break
        }
        // Методы которые активируют анимацию
        springAnimationView.animate()
        sender.animate()
        
        index += 1
        
    }
    
}

