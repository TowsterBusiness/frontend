import Foundation
import Combine

class RecipeViewModel: ObservableObject {
    @Published var recipes: [RecipeResponse] = []
    @Published var savedRecipes: [RecipeResponse] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRecipes() {
        guard let url = URL(string: "http://localhost:8000/test") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [RecipeResponse].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("Error fetching recipes:", error)
                }
            }, receiveValue: { [weak self] recipes in
                self?.recipes = recipes
            })
            .store(in: &cancellables)
    }
    
    func saveRecipe(_ recipe: RecipeResponse) {
        if !savedRecipes.contains(where: { $0.GeneralInfo.id == recipe.GeneralInfo.id }) {
            savedRecipes.append(recipe)
        }
    }
}
