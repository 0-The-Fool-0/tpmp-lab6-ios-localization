// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 3 (Swift)

import Foundation

struct BMIBMRRequest {
    let age: Double
    let heightCm: Double
    let weightKg: Double
    let gender: Gender
    let activityLevel: ActivityLevel
}

struct BMIBMRResult {
    let bmi: Double
    let bmiCategory: BMICategory
    let bmr: Double
    let maintenanceCalories: Double
}

enum Gender {
    case male
    case female
}

enum ActivityLevel: Double {
    case sedentary = 1.2
    case light = 1.375
    case moderate = 1.55
    case high = 1.725
    case veryHigh = 1.9

    static func from(index: Int) -> ActivityLevel {
        switch index {
        case 0: return .sedentary
        case 1: return .light
        case 2: return .moderate
        case 3: return .high
        default: return .veryHigh
        }
    }
}

enum BMICategory {
    case underweight
    case normal
    case overweight
    case obese

    var localizedTitle: String {
        switch self {
        case .underweight:
            return NSLocalizedString("task3_bmi_underweight", comment: "BMI underweight")
        case .normal:
            return NSLocalizedString("task3_bmi_normal", comment: "BMI normal")
        case .overweight:
            return NSLocalizedString("task3_bmi_overweight", comment: "BMI overweight")
        case .obese:
            return NSLocalizedString("task3_bmi_obese", comment: "BMI obese")
        }
    }
}

final class HealthCalculatorService {

    func calculate(request: BMIBMRRequest) -> BMIBMRResult {
        let bmi = calculateBMI(weightKg: request.weightKg, heightCm: request.heightCm)
        let bmr = calculateBMR(
            age: request.age,
            heightCm: request.heightCm,
            weightKg: request.weightKg,
            gender: request.gender
        )
        let maintenance = bmr * request.activityLevel.rawValue

        return BMIBMRResult(
            bmi: round2(bmi),
            bmiCategory: bmiCategory(for: bmi),
            bmr: round2(bmr),
            maintenanceCalories: round2(maintenance)
        )
    }

    private func calculateBMI(weightKg: Double, heightCm: Double) -> Double {
        let heightM = heightCm / 100.0
        return weightKg / (heightM * heightM)
    }

    // Harris-Benedict equation
    private func calculateBMR(age: Double, heightCm: Double, weightKg: Double, gender: Gender) -> Double {
        switch gender {
        case .male:
            return 88.362 + (13.397 * weightKg) + (4.799 * heightCm) - (5.677 * age)
        case .female:
            return 447.593 + (9.247 * weightKg) + (3.098 * heightCm) - (4.330 * age)
        }
    }

    private func bmiCategory(for bmi: Double) -> BMICategory {
        if bmi < 18.5 {
            return .underweight
        }
        if bmi < 25 {
            return .normal
        }
        if bmi < 30 {
            return .overweight
        }
        return .obese
    }

    private func round2(_ value: Double) -> Double {
        round(value * 100) / 100
    }
}
