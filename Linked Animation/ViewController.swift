import UIKit

class ViewController: UIViewController {
    
    lazy var squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 6
        view.frame = CGRect(x: slider.frame.origin.x, y: 150, width: 80, height: 80)
        return view
    }()
    
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .systemBlue
        slider.maximumTrackTintColor = .lightGray
        slider.frame = CGRect(x: view.layoutMargins.left, y: 300, width: view.bounds.width - view.layoutMargins.left - view.layoutMargins.right, height: 20)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(touchUpInsideSlider), for: .touchUpInside)
        return slider
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layoutMargins = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        view.addSubview(squareView)
        view.addSubview(slider)
    }
    
    
    // MARK: - Slider Value Changed
    @objc private func sliderValueChanged(_ sender: UISlider){
        let value = sender.value
        // Calculate new view dimensions and rotation angle
        let scaleFactor = 1 + CGFloat(value) * 0.5
        let rotationAngle = CGFloat(value) * CGFloat.pi / 2
        let screenWidthLeft = self.view.frame.width - view.layoutMargins.left - squareView.frame.width - view.layoutMargins.right
        
        let sliderFraction = CGFloat(sender.value / sender.maximumValue)
        
        let temporVar = squareView.frame.width / 2 + view.layoutMargins.left
        
        let updateCenterX = screenWidthLeft * sliderFraction + temporVar
        // Animation
        UIView.animate(withDuration: 0.5) {
            self.squareView.transform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor).rotated(by: rotationAngle)
            self.squareView.center.x = updateCenterX
            
        }
    }
    
    
    // MARK: - Touch Up Inside Slider
    @objc private func touchUpInsideSlider(_ sender: UISlider){
        UIView.animate(withDuration: 0.5) {
            self.squareView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5).rotated(by: .pi / 2)
            self.squareView.center.x = self.view.frame.width - self.view.layoutMargins.left - self.squareView.frame.width / 2
            sender.setValue(sender.maximumValue, animated: true)
            
        }
    }
}
