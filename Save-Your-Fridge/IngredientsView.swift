//
//  IngredientsView.swift
//  Save-Your-Fridge
//
//  Created by Towster on 10/21/25.
//

import SwiftUI

struct IngredientsView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var newIngredient = ""

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - Add Ingredient Field
                HStack {
                    TextField("Add ingredient...", text: $newIngredient)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)

                    Button(action: {
                        viewModel.addIngredient(newIngredient)
                        newIngredient = ""
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)

                // MARK: - Ingredients List
                if viewModel.ingredients.isEmpty {
                    VStack(spacing: 12) {
                        Text("No saved recipes yet.")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.gray)
                            .italic()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                } else {
                    Text("Swipe to remove ingredients!")
                        .foregroundColor(.secondary)
                    List {
                        ForEach(viewModel.ingredients, id: \.self) { ingredient in
                            Text(ingredient)
                        }
                        .onDelete(perform: deleteIngredient)
                    }
                    .listStyle(InsetGroupedListStyle())
                }

                // MARK: - Buttons
                HStack(spacing: 20) {
                    Button("Clear All") {
                        withAnimation {
                            viewModel.clearAllIngredients()
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                .padding(.bottom)
            }
            .navigationTitle("Ingredients")
        }
    }

    // MARK: - Delete Single Ingredient
    private func deleteIngredient(at offsets: IndexSet) {
        viewModel.deleteIngredient(offsets: offsets)
    }
}
