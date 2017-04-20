import UIKit
import InputValidator
import Validation

class ViewController: UIViewController {
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 0.5
        textField.delegate = self

        let indentView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 5))
        textField.leftView = indentView
        textField.leftViewMode = .always

        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            textField.widthAnchor.constraint(equalToConstant: 300),
            textField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.characters.count == 0 || string == "\n" {
            return true
        }

        var validation = Validation()
        validation.maximumLength = 5
        let inputValidator = InputValidator(validation: validation)
        return inputValidator.validateReplacementString(string, fullString: textField.text, inRange: range)
    }
}
