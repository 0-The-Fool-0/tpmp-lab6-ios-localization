// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 4 (SwiftUI)

import Foundation

struct Landmark: Identifiable {
    let id: UUID = UUID()
    let name: String
    let country: String
    let description: String
    let imageName: String
    var isFavorite: Bool
}

enum LandmarkRepository {
    static let all: [Landmark] = [
        Landmark(
            name: "Colosseum",
            country: "Italy",
            description: "Ancient amphitheater in Rome, one of the symbols of the Roman Empire.",
            imageName: "rome_colosseum",
            isFavorite: true
        ),
        Landmark(
            name: "Eiffel Tower",
            country: "France",
            description: "Wrought-iron tower and the main architectural symbol of Paris.",
            imageName: "paris_eiffel_tower",
            isFavorite: false
        ),
        Landmark(
            name: "Duomo di Milano",
            country: "Italy",
            description: "Gothic cathedral and one of the largest churches in Europe.",
            imageName: "milan_duomo",
            isFavorite: true
        )
    ]
}
