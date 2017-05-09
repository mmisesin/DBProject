//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

final class JustDevButton: UIView {
    fileprivate let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .center
        return imageView
    }()
    
    fileprivate let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: UIFontWeightHeavy)
        label.textAlignment = .center
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.imageView, self.label])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    public required init?(coder: NSCoder){
        super.init(coder: coder)
        initPhase2()
    }
    
    public override init(frame: CGRect){
        super.init(frame: frame)
        initPhase2()
    }
    
    private func initPhase2() {
        layer.cornerRadius = 20
        layer.borderWidth = 10
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            label.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3)])
    }
}

extension JustDevButton {
//    var image: UIImage? {
//        g
//        set {
//            imageView.image = newValue?.withRenderingMode(.alwaysTemplate)
//        }
//    }
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    override func tintColorDidChange() {
        label.backgroundColor = tintColor
        layer.borderColor = tintColor.cgColor
    }
}

let dimensions = (width: 200, height: 200)
let jdButton = JustDevButton(frame: CGRect(x: dimensions.width/2, y: dimensions.height/2, width: dimensions.width, height: dimensions.height/2))
jdButton.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.85)
jdButton.text = "Wadup, pimps"

PlaygroundPage.current.liveView = jdButton
PlaygroundPage.current.needsIndefiniteExecution = true
