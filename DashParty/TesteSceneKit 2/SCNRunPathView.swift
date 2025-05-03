//
//  SCNRunPathView.swift
//  TesteSceneKit
//
//  Created by Ricardo Almeida Venieris on 30/04/25.
//

import UIKit
import SceneKit

class SCNRunPathView: SCNView {

    let runPathScene = SCNRunPathScene()
    
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = UIColor(white: 0, alpha: 0.5)
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " 0.0 m "
        label.layer.zPosition = 1000
        label.layer.cornerRadius = 30
        return label
    }()

    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        setup()
        
    }
    
    func setup() {
        // set the scene to the view
        self.scene = runPathScene

        // allows the user to manipulate the camera
        self.allowsCameraControl = false
        
        // show statistics such as fps and timing information
        self.showsStatistics = false
        //        scnView.debugOptions = [.showPhysicsShapes]
        
        // configure the view
        self.backgroundColor = UIColor.black
        
        self.debugOptions = [.showPhysicsShapes]

        addSubview(distanceLabel)
        
        runPathScene.runner.ontrot = { distance, speed in
            DispatchQueue.main.async {
                self.distanceLabel.text = String(format: " %.1fm    %.1fm/s ", distance, speed)
            }
            
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            // Centraliza horizontalmente
            distanceLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            // Fixa no topo com margem de 10 pontos
            distanceLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }

}
