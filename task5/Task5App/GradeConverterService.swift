// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Variant 3, Task 5

import Foundation

struct GradeConversionRequest {
    let mathematicalAnalysis: Double
    let geometryAndAlgebra: Double
    let programming: Double
    let targetScale: GradeScale
}

struct GradeConversionResult {
    let mathematicalAnalysis: Double
    let geometryAndAlgebra: Double
    let programming: Double
    let average: Double
}

enum GradeScale {
    case five
    case twelve
    case twentyFive

    var maxValue: Double {
        switch self {
        case .five:
            return 5
        case .twelve:
            return 12
        case .twentyFive:
            return 25
        }
    }

    var title: String {
        switch self {
        case .five:
            return NSLocalizedString("task5_scale_5", comment: "5-point scale title")
        case .twelve:
            return NSLocalizedString("task5_scale_12", comment: "12-point scale title")
        case .twentyFive:
            return NSLocalizedString("task5_scale_25", comment: "25-point scale title")
        }
    }

    var shortTitle: String {
        switch self {
        case .five:
            return "5"
        case .twelve:
            return "12"
        case .twentyFive:
            return "25"
        }
    }
}

final class GradeConverterService {

    func convert(request: GradeConversionRequest) -> GradeConversionResult {
        let convertedAnalysis = convertFrom10Point(request.mathematicalAnalysis, to: request.targetScale)
        let convertedGeometry = convertFrom10Point(request.geometryAndAlgebra, to: request.targetScale)
        let convertedProgramming = convertFrom10Point(request.programming, to: request.targetScale)

        let average10 = (request.mathematicalAnalysis + request.geometryAndAlgebra + request.programming) / 3.0
        let convertedAverage = convertFrom10Point(average10, to: request.targetScale)

        return GradeConversionResult(
            mathematicalAnalysis: convertedAnalysis,
            geometryAndAlgebra: convertedGeometry,
            programming: convertedProgramming,
            average: convertedAverage
        )
    }

    private func convertFrom10Point(_ value: Double, to scale: GradeScale) -> Double {
        let rawValue = (value / 10.0) * scale.maxValue
        return round(rawValue * 100) / 100
    }
}
