//
//  CategoryPickerView.swift
//  V-IS
//
//  Created by Kirti on 3/2/25.
//

import SwiftUI

struct CategoryPickerView: View {
    @Binding var selectedCategory: Category
    
    var body: some View {
        Picker("Category", selection: $selectedCategory) {
            Text("Movies").tag(Category.movies)
            Text("TV Shows").tag(Category.tvShows)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
}
