// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 3 (Swift)

import UIKit

final class BMIBMRCalculatorViewController: UIViewController {

    // MARK: - IBOutlets
    private var ageTextField: UITextField!
    private var heightTextField: UITextField!
    private var weightTextField: UITextField!
    private var genderSegmentedControl: UISegmentedControl!
    private var activitySegmentedControl: UISegmentedControl!
    private var resultLabel: UILabel!

    private let calculator = HealthCalculatorService()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureInitialUI()
    }

    // MARK: - Actions
    @objc private func calculateTapped(_ sender: UIButton) {
        guard
            let age = parse(valueFrom: ageTextField, range: 10...100),
            let height = parse(valueFrom: heightTextField, range: 100...240),
            let weight = parse(valueFrom: weightTextField, range: 30...250)
        else {
            resultLabel.text = NSLocalizedString("task3_error_input", comment: "Validation error")
            resultLabel.textColor = .systemRed
            return
        }

        let gender: Gender = genderSegmentedControl.selectedSegmentIndex == 0 ? .male : .female
        let activity = ActivityLevel.from(index: activitySegmentedControl.selectedSegmentIndex)
        let request = BMIBMRRequest(age: age, heightCm: height, weightKg: weight, gender: gender, activityLevel: activity)
        let result = calculator.calculate(request: request)

        resultLabel.textColor = .label
        resultLabel.text = """
        \(NSLocalizedString("task3_bmi", comment: "BMI")): \(format(result.bmi))
        \(NSLocalizedString("task3_bmi_category", comment: "BMI category")): \(result.bmiCategory.localizedTitle)
        \(NSLocalizedString("task3_bmr", comment: "BMR")): \(format(result.bmr)) kcal/day
        \(NSLocalizedString("task3_maintenance", comment: "Calories maintenance")): \(format(result.maintenanceCalories)) kcal/day
        """
    }

    // MARK: - Helpers
    private func setupUI()
        configureInitialUI() {
        resultLabel.text = NSLocalizedString("task3_placeholder", comment: "Placeholder")
        resultLabel.textColor = .secondaryLabel
    }

    private func parse(valueFrom textField: UITextField, range: ClosedRange<Double>) -> Double? {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let value = Double(text),
              range.contains(value) else {
            return nil
        }
        return value
    }

    private func format(_ value: Double) -> String {
        String(format: "%.2f", value)
    }
}
