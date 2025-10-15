import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        List(viewModel.savedRecipes, id: \.GeneralInfo.id) { recipe in
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
        .navigationTitle("Saved Recipes")
    }
}
