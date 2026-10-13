// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
import UIKit
final class GradesInputViewController: UIViewController {
    private let mathField = UITextField()
    private let geometryField = UITextField()
    private let programmingField = UITextField()
    private let scaleControl = UISegmentedControl(items: ["5", "12", "25"])
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("task5_title_input", comment: "")
        view.backgroundColor = .systemBackground
        [mathField, geometryField, programmingField].forEach { $0.borderStyle = .roundedRect; $0.keyboardType = .decimalPad }
        mathField.placeholder = NSLocalizedString("task5_subject_analysis", comment: "")
        geometryField.placeholder = NSLocalizedString("task5_subject_geometry", comment: "")
        programmingField.placeholder = NSLocalizedString("task5_subject_programming", comment: "")
        let button = UIButton(type: .system)
        button.setTitle(NSLocalizedString("task5_convert", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(convertTapped), for: .touchUpInside)
        let stack = UIStackView(arrangedSubviews: [mathField, geometryField, programmingField, scaleControl, button])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    @objc private func convertTapped() {
        guard let a = parse(mathField), let g = parse(geometryField), let p = parse(programmingField) else {
            showAlert(NSLocalizedString("task5_error_input", comment: "")); return
        }
        let scale: GradeScale = scaleControl.selectedSegmentIndex == 0 ? .five : (scaleControl.selectedSegmentIndex == 1 ? .twelve : .twentyFive)
        let result = GradeConverterService().convert(request: .init(mathematicalAnalysis: a, geometryAndAlgebra: g, programming: p, targetScale: scale))
        navigationController?.pushViewController(GradesResultViewController(result: result, scale: scale), animated: true)
    }
    private func parse(_ f: UITextField) -> Double? {
        guard let t = f.text?.trimmingCharacters(in: .whitespacesAndNewlines), let v = Double(t), (0...10).contains(v) else { return nil }
        return v
    }
    private func showAlert(_ m: String) {
        let a = UIAlertController(title: nil, message: m, preferredStyle: .alert)
        a.addAction(UIAlertAction(title: "OK", style: .default))
        present(a, animated: true)
    }
}
