// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 4 (SwiftUI)

import SwiftUI

struct LandmarkListView: View {
    @State private var showFavoritesOnly = false
    @State private var landmarks = LandmarkRepository.all

    private var filteredLandmarks: [Landmark] {
        landmarks.filter { !showFavoritesOnly || $0.isFavorite }
    }

    var body: some View {
        NavigationStack {
            List {
                Toggle("Favorites only", isOn: $showFavoritesOnly)

                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetailView(landmark: landmark)
                    } label: {
                        LandmarkRowView(landmark: landmark)
                    }
                }
            }
            .navigationTitle("Landmarks")
        }
    }
}

#Preview {
    LandmarkListView()
}
