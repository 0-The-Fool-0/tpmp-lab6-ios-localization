// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 1 (Swift)

import UIKit

final class BackgroundSwitchViewController: UIViewController {

    // MARK: - IBOutlets
    private var backgroundSwitch: UISwitch!
    private var switchIndicator: UILabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureInitialState()
    }

    // MARK: - Actions
    @objc private func backgroundSwitchTapped(_ sender: UISwitch) {
        applyBackgroundState(isOn: sender.isOn)
    }

    // MARK: - Helpers
    private func setupUI()
        configureInitialState() {
        backgroundSwitch.isOn = false
        switchIndicator.textColor = .white
        applyBackgroundState(isOn: false)
    }

    private func applyBackgroundState(isOn: Bool) {
        let imageName = isOn ? "bg1" : "bg2"
        let indicatorKey = isOn ? "task1_indicator_bg1" : "task1_indicator_bg2"

        switchIndicator.text = NSLocalizedString(indicatorKey, comment: "Background indicator text")

        guard let backgroundImage = UIImage(named: imageName) else {
            view.backgroundColor = .systemGray
            switchIndicator.text = NSLocalizedString("task1_missing_image", comment: "Missing image warning")
            return
        }
        view.backgroundColor = UIColor(patternImage: backgroundImage)
    }
}
