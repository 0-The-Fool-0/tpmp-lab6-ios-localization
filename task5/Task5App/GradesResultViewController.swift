// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
import UIKit
final class GradesResultViewController: UIViewController {
    private let result: GradeConversionResult
    private let scale: GradeScale
    init(result: GradeConversionResult, scale: GradeScale) {
        self.result = result
        self.scale = scale
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { nil }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("task5_title_result", comment: "")
        view.backgroundColor = .systemBackground
        let label = UILabel()
        label.numberOfLines = 0
        label.text = """
        \(scale.title):
        \(NSLocalizedString("task5_subject_analysis", comment: "")): \(fmt(result.mathematicalAnalysis))
        \(NSLocalizedString("task5_subject_geometry", comment: "")): \(fmt(result.geometryAndAlgebra))
        \(NSLocalizedString("task5_subject_programming", comment: "")): \(fmt(result.programming))
        \(NSLocalizedString("task5_average", comment: "")): \(fmt(result.average))
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func fmt(_ v: Double) -> String { String(format: "%.2f", v) }
}
