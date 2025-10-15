import Foundation

struct RecipeResponse: Codable {
    let GeneralInfo: RecipeGeneral
    let instructions: [String]?
    let nutrition: Nutrition?
    let price: Double?
}

struct RecipeGeneral: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let missedIngredients: Int
    let usedIngredients: [String]
}

struct Nutrition: Codable {
    let calories: String?
    let fat: String?
    let protein: String?
    let carbohydrates: String?
}
