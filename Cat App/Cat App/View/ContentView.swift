//
//  ContentView.swift
//  Cat App
//
//  Created by Miguel Castellanos on 3/02/25.
//

import SwiftUI
import Kingfisher

struct ContentView: View {
    
    
    @ObservedObject var viewModel = Factory.makeViewModel()
    @State var searchText: String = ""
    
    var breeds: [BreedModel] {
        if searchText.isEmpty {
            return viewModel.breeds
        } else {
            return viewModel.breeds.filter{
                return $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if breeds.isEmpty {
                    if !viewModel.errorMessage.isEmpty {
                        VStack {
                            Text("There was an error fetching data. Please check your internet connection.")
                                .frame(width: 300, alignment: .center)
                            Image("network_error")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                    } else {
                        Text("Loading...")
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    }
                } else {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 178))], content: {
                        ForEach(breeds, id: \.id) { breed in
                            NavigationLink(destination: BreedDetailedView(breed: breed)) {
                                breedView(breed: breed)
                            }
                            .padding(EdgeInsets(top: 7, leading: 7, bottom: 7, trailing: 7))
                        }
                    })
                    .accessibilityIdentifier("Grid of Breeds")
                }
            }
            .navigationBarTitle(Text("Breeds Info App"), displayMode: .inline)
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .automatic),
                prompt: "Filter by breed name")
            if !breeds.isEmpty {
                HStack{
                    if (viewModel.pageNumber != 0) {
                        Button("Previous <<") {
                            viewModel.pageNumber -= 1
                            viewModel.loadPage()
                        }
                        .accessibilityIdentifier("Previous")
                    }
                    Spacer()
                        .frame(width: 70);
                    Text("Page \(viewModel.pageNumber + 1)");
                    Spacer()
                        .frame(width: 70);
                    
                    if (viewModel.pageNumber < 6) {
                        Button(">> Next") {
                            viewModel.pageNumber += 1
                            viewModel.loadPage()
                        }
                        .accessibilityIdentifier("Next")
                    }
                    
                }
            }
        }
        
    }
    
    func breedView(breed: BreedModel) -> some View {
        let imageId = (breed.referenceImageID ?? BusinessConstants.defaultImageId.rawValue) + ".jpg"
        let imageURL = BusinessConstants.imageAPIUrl.rawValue + imageId
        return ZStack {
            Rectangle()
                .cornerRadius(30)
                .frame(width: 178, height: 178)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 15)
            VStack {
                Text(breed.name)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(EdgeInsets(top: 2, leading: 7, bottom: 7, trailing: 7))
                imageView(url: imageURL)
                    .accessibilityIdentifier("Cell Image")
            }
        }
    }
    
    func imageView(url: String) -> some View {
        KFImage(URL(string: url))
            .setProcessor(ResizingImageProcessor(referenceSize: CGSize(width: 160 , height: 120), mode: .aspectFit))
            .placeholder {
                Image("cat_placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120)
            }
            .cornerRadius(30)
    }
}


#Preview {
    ContentView()
}
