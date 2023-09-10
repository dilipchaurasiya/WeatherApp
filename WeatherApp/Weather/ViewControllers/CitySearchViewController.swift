//
//  CitySearchViewController.swift
//  WeatherApp
//
//  Created by Dilip Chaurasiya on 10/09/23.
//

import UIKit

protocol CitySearchDelegate {
    func citySelected(name: String)
}

class CitySearchViewController: UIViewController {

    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    
    var delegate: CitySearchDelegate?
    
    var disabled = true {
        didSet {
            goButton.isHidden = disabled
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disabled = true
        cityTextField.addTarget(self, action: #selector(textFieldDidChange(_:)),
                                  for: .editingChanged)

    }
    
    @IBAction func goButtonAction(_ sender: Any) {
        delegate?.citySelected(name: cityTextField.text ?? "")
        self.dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        disabled = textField.text?.count ?? 0 <= 0
    }
    
}

