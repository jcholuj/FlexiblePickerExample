//
//  FlexiblePicker.swift
//  FlexiblePickerExample
//
//  Created by Jędrzej Chołuj on 23/01/2022.
//

import SwiftUI

struct FlexiblePicker<T: Selectable>: View {
    
    @Binding var inputData: [T]
    
    var fontWeight: FontWeight = .medium
    var fontSize: CGFloat = 16
    var spacing: CGFloat = 12
    var textPadding: CGFloat = 8
    var textColor: Color = .black
    var selectedColor: Color = .blue
    var notSelectedColor: Color = .clear
    var borderWidth: CGFloat = 2
    var borderColor: Color = .blue
    var alignment: HorizontalAlignment = .center
    var cornerRadius: CGFloat = 10
    var isSelectable: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: alignment, spacing: spacing) {
                ForEach(divideDataIntoLines(lineWidth: geo.size.width).map { (data: $0, id: UUID()) }, id: \.id) { dataArray in
                    Group {
                        HStack(spacing: spacing) {
                            ForEach(dataArray.data, id: \.id) { data in
                                Button(action: { updateSelectedData(with: data)
                                }) {
                                    Text(data.displayedName)
                                        .lineLimit(1)
                                        .foregroundColor(textColor)
                                        .font(.system(size: fontSize, weight: fontWeight.swiftUIFontWeight))
                                        .padding(textPadding)
                                }
                                .background(
                                    data.isSelected
                                    ? selectedColor.opacity(0.5)
                                    : notSelectedColor.opacity(0.5)
                                )
                                .cornerRadius(10)
                                .disabled(!isSelectable)
                                .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(borderColor, lineWidth: borderWidth))
                            }
                        }
                    }
                }
            }
            .frame(width: geo.size.width, height: calculateVStackHeight(width: geo.size.width))
        }
    }
    
    private func updateSelectedData(with data: T) {
        guard let index = inputData.indices.first(where: { inputData[$0] == data }) else {
            return
        }
        withAnimation(.easeInOut(duration: 0.5)) {
            inputData[index].isSelected.toggle()
        }
    }
    
    private func divideDataIntoLines(lineWidth: CGFloat) -> [[T]] {
        let data = calculateWidths(for: inputData)
        var singleLineWidth = lineWidth
        var dataArrays = [[T]]()
        var singleLineResult = [T]()
        var partialWidthResult: CGFloat = 0
        data.forEach { (selectableType, width) in
            partialWidthResult = singleLineWidth - width
            if partialWidthResult > 0 {
                singleLineResult.append(selectableType)
                singleLineWidth -= width
            } else {
                dataArrays.append(singleLineResult)
                singleLineResult = [selectableType]
                singleLineWidth = lineWidth - width
            }
        }
        guard !singleLineResult.isEmpty else { return dataArrays }
        dataArrays.append(singleLineResult)
        return dataArrays
    }
    
    private func calculateWidths(for data: [T]) -> [(value: T, width: CGFloat)] {
        return data.map { selectableType -> (T, CGFloat) in
            var width = selectableType.displayedName.getWidth(with: .systemFont(ofSize: fontSize, weight: fontWeight.uiFontWeight))
            let additionalWidth = [textPadding, textPadding, borderWidth, borderWidth, spacing].reduce(0, +)
            width += additionalWidth
            return (selectableType, width)
        }
    }
    
    private func calculateVStackHeight(width: CGFloat) -> CGFloat {
        let data = divideDataIntoLines(lineWidth: width)
        guard let textHeight = data.first?.first?.displayedName.getHeight(with: .systemFont(ofSize: fontSize, weight: fontWeight.uiFontWeight)) else { return 16 }
        let result = [textHeight, textPadding, textPadding, borderWidth, borderWidth, spacing].reduce(0, +)
        return result * CGFloat(data.count)
    }
}

struct FlexiblePicker_Previews: PreviewProvider {
    static var previews: some View {
        FlexiblePicker<SelectableModel>(inputData: .constant([]))
    }
}
