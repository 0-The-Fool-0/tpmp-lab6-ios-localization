// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 4 (SwiftUI)

import SwiftUI

struct LandmarkDetailView: View {
    let landmark: Landmark

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Image(landmark.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 240)
                    .clipShape(RoundedRectangle(cornerRadius: 16))

                Text(landmark.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text(landmark.country)
                    .font(.title3)
                    .foregroundStyle(.secondary)

                Text(landmark.description)
                    .font(.body)
            }
            .padding()
        }
        .navigationTitle(landmark.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    LandmarkDetailView(landmark: LandmarkRepository.all[0])
}
