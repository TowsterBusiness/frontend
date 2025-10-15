import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.recipes, id: \.GeneralInfo.id) { recipe in
                NavigationLink(destination: RecipeDetailView(recipe: recipe, viewModel: viewModel)) {
                    HStack {
                        AsyncImage(url: URL(string: recipe.GeneralInfo.image)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 80, height: 80)
                        .cornerRadius(8)
                        
                        VStack(alignment: .leading) {
                            Text(recipe.GeneralInfo.title)
                                .font(.headline)
                            Text("\(recipe.GeneralInfo.usedIngredients.count) ingredients")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .onAppear {
                viewModel.fetchRecipes()
            }
        }
    }
}
