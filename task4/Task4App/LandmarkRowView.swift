// Author: Борисовец Андрей Дмитриевич, TPMP GR11A
// Lab 6, Task 4 (SwiftUI)

import SwiftUI

struct LandmarkRowView: View {
    let landmark: Landmark

    var body: some View {
        HStack(spacing: 12) {
            Image(landmark.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 44, height: 44)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.headline)
                Text(landmark.country)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if landmark.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            }
        }
    }
}

#Preview {
    LandmarkRowView(landmark: LandmarkRepository.all[0])
}
