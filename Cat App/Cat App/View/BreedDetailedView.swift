//
//  BreedDetailedView.swift
//  Cat App
//
//  Created by Miguel Castellanos on 5/02/25.
//

import SwiftUI
import Kingfisher

struct BreedDetailedView: View {
    @State var breed: BreedModel?
    @State var image: (any View)?
    var body: some View {
        if let breed {
            ZStack {
                Rectangle()
                    .cornerRadius(30)
                    .foregroundColor(.blue.opacity(0.1))
                    .shadow(color: .black, radius: 15)
                    .frame(width: 340)
                    .containerRelativeFrame(.horizontal)
                VStack {
                    Text(breed.name)
                        .font(.largeTitle.bold())
                    let imageId = (breed.referenceImageID ?? BusinessConstants.defaultImageId.rawValue) + ".jpg"
                    let imageURL = BusinessConstants.imageAPIUrl.rawValue + imageId
                    KFImage(URL(string: imageURL))
                        .setProcessor(ResizingImageProcessor(referenceSize: CGSize(width: 320, height: 300), mode: .aspectFit))
                        .placeholder {
                            Image("cat_placeholder")
                                .frame(width: 300)
                                .scaledToFit()
                        }
                        .cornerRadius(30)
                    ZStack {
                        Rectangle()
                            .cornerRadius(30)
                            .foregroundColor(.blue.opacity(0.1))
                            .frame(width: 320)
                        VStack {
                            Text("A little about..")
                                .font(.title)
                            ScrollView {
                                Text(breed.description)
                                    .frame(width: 300)
                                    .font(.body)
                            }
                        }
                        .frame(height: 160)
                    }
                    .frame(height: 200)
                    HStack {
                        VStack {
                            Text("They are..")
                                .font(.title2)
                            Text(breed.temperament)
                                .font(.body)
                        }
                        .frame(width: 160)
                        VStack {
                            ProgressView("Child Friendly", value: Double(breed.childFriendly)/Double(5))
                            ProgressView("Energy Level", value: Double(breed.energyLevel)/Double(5))
                            ProgressView("Affectionate", value: Double(breed.affectionLevel)/Double(5))
                            ProgressView("Intelligence", value: Double(breed.intelligence)/Double(5))
                        }
                        .frame(width: 120)
                    }
                    
                }
            }
        }
    }
}

#Preview {
    BreedDetailedView()
}
