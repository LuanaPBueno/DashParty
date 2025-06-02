//
//  TutorialSheet.swift
//  DashParty
//
//  Created by Fernanda Auler on 25/04/25.
//

import SwiftUI

struct TutorialSheet: View {
    var tutorialImage: String
    var tutorialText: String
    var tutorialTextTitle: String
    var size: CGSize

    var body: some View {
        ZStack {
            Image("tutorialRectangle")
                .resizable()
                .scaledToFit()
                .frame(width: size.width * 0.50)
                .clipped()

            HStack(spacing: size.width * 0.02) {
                Image(tutorialImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size.width * 0.20, height: size.width * 0.18)
                    .clipped()

                VStack(alignment: .leading, spacing: size.height * 0.01) {
                    Text(tutorialTextTitle)
                        .font(.custom("TorukSC-Regular", size: (size.width / 1920) * 40))
                        .foregroundStyle(.lowOpacityText)
                        .frame(maxWidth: size.width * 0.24, alignment: .leading)

                    Image("tutorialLine")
                        .resizable()
                        .scaledToFit()
                        .frame(width: size.width * 0.20)

                    Text(tutorialText)
                        .font(.custom("Wonder-Light", size: (size.width / 1920) * 30))
                        .foregroundStyle(.text)
                        .frame(maxWidth: size.width * 0.24, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(.horizontal, size.width * 0.03)
        }
    }
}

#Preview {
    TutorialSheet(
        tutorialImage: "tutorialImage3",
        tutorialText: "Keep your phone in a vertical position throughout the race.",
        tutorialTextTitle: "Run",
        size: CGSize(width: 2388, height: 1668)
    )
}
