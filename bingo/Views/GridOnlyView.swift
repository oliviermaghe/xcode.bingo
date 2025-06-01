import SwiftUI

struct GridOnlyView: View {
    @ObservedObject var model: BingoModel

    var body: some View {
        GeometryReader { geo in
            let columnsCount = 10
            let totalNumbers = model.maxNumber
            let lines = (totalNumbers + columnsCount - 1) / columnsCount
            
            let verticalPadding: CGFloat = 40
            let horizontalPadding: CGFloat = 20
            
            let availableWidth = geo.size.width - horizontalPadding
            let availableHeight = geo.size.height - verticalPadding
            
            let spacing: CGFloat = 10
            
            let cellWidth = (availableWidth - spacing * CGFloat(columnsCount - 1)) / CGFloat(columnsCount)
            let cellHeight = (availableHeight - spacing * CGFloat(lines - 1)) / CGFloat(lines)
            
            let cellSize = min(max(min(cellWidth, cellHeight), 25), 80)
            
            let columns = Array(repeating: GridItem(.flexible(minimum: cellSize, maximum: cellSize), spacing: spacing), count: columnsCount)
            
            
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture(count: 2) {
                        GridWindowController.toggleFullScreen()
                    }
                // Centrage avec VStack+HStack + Spacer
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: spacing) {
                                ForEach(1...totalNumbers, id: \.self) { num in
                                    BallView(
                                        number: num,
                                        isDrawn: model.drawnNumbers.contains(num)
                                    ) {
                                        model.toggleNumber(num)
                                    }
                                    .frame(width: cellSize, height: cellSize)
                                }
                            }
                            .padding(.horizontal, spacing)
                            .padding(.vertical, 5)
                        }
                        .frame(
                            width: CGFloat(columnsCount) * (cellSize + spacing) - spacing + spacing * 2,
                            height: CGFloat(lines) * (cellSize + spacing) - spacing + 10
                        )
                        Spacer()
                    }
                    Spacer()
                }
            }

        }
        .frame(minWidth: 400, minHeight: 400)
    }
}
