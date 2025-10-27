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
    @State private var ingredients: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                // Add ingredient manually
                HStack {
                    TextField("Add ingredient...", text: $newIngredient)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.leading)

                    Button(action: { addIngredient(newIngredient) }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .padding(.trailing)
                }
                .padding(.vertical)

                // List of ingredients
                List {
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text(ingredient)
                    }
                    .onDelete(perform: deleteIngredient)
                }
                .listStyle(InsetGroupedListStyle())

                // Example button (for testing backend response)
                Button("Load Sample Ingredients") {
                    let sampleResponse = "Jam, Dressing, Mustard, Salsa, Pickles, Maple Syrup, Yogurt, Milk, Creamer, Hummus, Eggs, Strawberries, Blueberries, Bell Peppers, Carrots, Oranges, Apples, Lettuce, Spinach, Deli Meat, Cheese, Butter, Bread, Juice, Water, Hot Sauce, Ketchup, Mayonnaise, Lemon Juice, Limes, Olives, Pesto, Soy Sauce, Tortillas, Sliced Cheese, Fruit Preserves"
                    addIngredients(from: sampleResponse)
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
            .navigationTitle("Ingredients")
        }
    }

    // MARK: - Add Single Ingredient
    private func addIngredient(_ name: String) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, !ingredients.contains(trimmed) else { return }
        ingredients.append(trimmed)
        newIngredient = ""
    }

    // MARK: - Add Multiple Ingredients (comma-separated)
    private func addIngredients(from string: String) {
        let parsed = string
            .split(separator: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .filter { !$0.isEmpty }

        for ingredient in parsed {
            if !ingredients.contains(ingredient) {
                ingredients.append(ingredient)
            }
        }
    }

    // MARK: - Delete Ingredient
    private func deleteIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
}
