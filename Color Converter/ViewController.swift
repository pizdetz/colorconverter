//
//  ViewController.swift
//  Color Converter
//
//  Created by Colton Sweeney on 8/25/17.
//  Copyright © 2017 coltoncsweeney. All rights reserved.
//

// Tasks:
// Select which conversion we want to perform : DONE
// Enter in 4 text values (for each color and an alpha value) :
// When button is pressed, perform conversion and display results and display color

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    @IBOutlet weak var alphaTextField: UITextField!
    @IBOutlet weak var conversionButton: UIButton!
    @IBOutlet weak var resultsLabel: UILabel!
    
    enum Conversion {
        case hexToRGB
        case RGBtoHex
    }
    var conversion : Conversion = .hexToRGB

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func selectSegmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            conversion = .hexToRGB
            conversionButton.setTitle("Convert Hex to RGB", for: .normal)
        case 1:
            conversion = .RGBtoHex
            conversionButton.setTitle("Convert RGB to Hex", for: .normal)
        default:
            conversion = .hexToRGB
            conversionButton.setTitle("Convert Hex to RGB", for: .normal)
        }
        print(conversion)
        redTextField.text?.removeAll()
        greenTextField.text?.removeAll()
        blueTextField.text?.removeAll()
        alphaTextField.text?.removeAll()
    }

    @IBAction func convertAction(_ sender: UIButton) {
        switch conversion {
        case .hexToRGB:
            self.view.backgroundColor = convertHexToRGB()
        case .RGBtoHex:
            self.view.backgroundColor = convertRGBtoHex()
        }
    }
    
    func convertHexToRGB() -> UIColor? {
        guard let redText = UInt8(redTextField.text!, radix: 16) else { return nil }
        guard let greenText = UInt8(greenTextField.text!, radix: 16) else { return nil }
        guard let blueText = UInt8(blueTextField.text!, radix: 16) else { return nil }
        guard let alphaText = Float(alphaTextField.text!) else { return nil }
        if (alphaText > 1 || alphaText < 0) {
            return nil
        }
        
        print("Text entered \(redText), \(greenText), \(blueText), \(alphaText)")
        
        resultsLabel.text = "Red Value: \(redText)\nGreen Value: \(greenText)\nBlue Value: \(blueText)\nAlpha Value: \(alphaText)"
        let backgroundColor = UIColor.init(colorLiteralRed: Float(redText)/255, green: Float(greenText)/255, blue: Float(blueText)/255, alpha: alphaText)
        return backgroundColor
    }
    
    func convertRGBtoHex() -> UIColor? {
        guard let redText = UInt8(redTextField.text!) else { return nil }
        guard let greenText = UInt8(greenTextField.text!) else { return nil }
        guard let blueText = UInt8(blueTextField.text!) else { return nil }
        guard let alphaText = Float(alphaTextField.text!) else { return nil }
        if (alphaText > 1 || alphaText < 0) {
            return nil
        }
        
        let redString = String(format: "%2X", redText)
        let greenString = String(format: "%2X", greenText)
        let blueString = String(format: "%2X", blueText)
        
        print("Text entered \(redText), \(greenText), \(blueText), \(alphaText)")
        
        resultsLabel.text = "Hex Code: #\(redString)\(greenString)\(blueString)\nAlpha: \(alphaText)"
        let backgroundColor = UIColor.init(colorLiteralRed: Float(redText)/255, green: Float(greenText)/255, blue: Float(blueText)/255, alpha: alphaText)
        return backgroundColor
    }
}

