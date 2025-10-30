//
//  CameraScreen.swift
//  Save-Your-Fridge
//
//  Created by Towster on 10/1/25.
//

import SwiftUI

struct CameraScreen: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    @State private var showCamera = false
    @State private var image: UIImage?
    @State private var responseText = "No response yet"
    @State private var isLoading = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // MARK: - Image Preview
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 200)
                        .overlay(
                            Text("No Photo Yet")
                                .foregroundColor(.gray)
                        )
                }

                // MARK: - Buttons
                Button("📸 Take Photo") {
                    showCamera = true
                }
                .buttonStyle(.borderedProminent)
                .padding()

                Button("⬆️ Upload Photo") {
                    uploadImageForIngredients()
                }
                .buttonStyle(.bordered)
                .disabled(image == nil || isLoading)

                // MARK: - Loading / Response
                if isLoading {
                    ProgressView("Uploading...")
                        .padding()
                } else {
                    Text(responseText)
                        .padding()
                        .foregroundColor(.blue)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding()
            .sheet(isPresented: $showCamera) {
                CameraView(image: $image)
            }
            .navigationTitle("Camera Upload")
        }
    }

    // MARK: - Upload Logic
    private func uploadImageForIngredients() {
        guard let image = image else { return }
        isLoading = true
        responseText = "Uploading image..."

        ImageUploader.shared.uploadImageForIngredients(image) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let ingredientString):
                    responseText = "✅ Ingredients added!"
                    print("Server ingredients: \(ingredientString)")
                    viewModel.addIngredients(from: ingredientString)
                case .failure(let error):
                    responseText = "❌ Upload failed: \(error.localizedDescription)"
                }
            }
        }
    }
}
