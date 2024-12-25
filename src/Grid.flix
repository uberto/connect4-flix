/// Represents a cell in the Connect4 grid
pub enum Cell {
    case Empty,
    case Red,
    case Yellow
}

/// Functions for handling the Connect4 grid
mod Grid {
    use Cell.{Empty, Red, Yellow}

    /// Creates a list of n identical cells
    pub def mkCellList(cell: Cell, n: Int32): List[Cell] =
        List.range(0, n) |> List.map(_ -> cell)

    /// Creates an empty grid of width x height
    pub def mkEmptyGrid(width: Int32, height: Int32): List[List[Cell]] =
        List.range(0, height) |> List.map(_ -> mkCellList(Empty, width))

    /// Places a disc in the specified column of the grid.
    /// The disc will "fall" to the lowest empty position in that column.
    pub def placeDisc(grid: List[List[Cell]], col: Int32, player: Cell): List[List[Cell]] =
        // Helper function to update a single row
        def updateRow(row: List[Cell], c: Int32): List[Cell] =
            List.mapWithIndex((i, cell) -> if (i == c) player else cell, row);

        // Helper function to find the lowest empty position
        def findLowestEmpty(rows: List[List[Cell]], r: Int32): Option[Int32] =
            match rows {
                case Nil => None
                case row :: rest => {
                    let cell = List.mapWithIndex((i, c) -> (i, c), row) 
                              |> List.find(x -> fst(x) == col) 
                              |> Option.map(x -> snd(x));
                    match cell {
                        case None => None
                        case Some(Empty) => Some(r)
                        case Some(_) => findLowestEmpty(rest, r - 1)
                    }
                }
            };

        // Find the lowest empty position and update the grid
        match findLowestEmpty(List.reverse(grid), List.length(grid) - 1) {
            case None => grid  // Column is full or invalid
            case Some(row) => List.mapWithIndex((r, rowList) -> 
                if (r == row) updateRow(rowList, col)
                else rowList
            , grid)
        }

    /// Converts a cell to its string representation
    def cellToString(cell: Cell): String = match cell {
        case Empty => "   "
        case Red => " R "
        case Yellow => " Y "
    }

    /// Generates a horizontal line for the grid
    def horizontalLine(width: Int32): String =
        repeat("+---", width) + "+"

    /// Helper function to repeat a string n times
    def repeat(s: String, n: Int32): String =
        if (n <= 0) ""
        else if (n == 1) s
        else s + repeat(s, n - 1)

    /// Generates a string representation of the grid from a matrix of cells
    pub def gridToString(grid: List[List[Cell]]): String = 
        let width = match List.head(grid) {
            case None => 0
            case Some(row) => List.length(row)
        };
        
        // Generate the grid string
        let rowStrings = List.map(row -> {
            // Convert cells to strings and concatenate with separators
            let cellsStr = List.foldLeft((acc, cell) -> 
                if (acc == "") "|" + cellToString(cell)
                else acc + "|" + cellToString(cell)
            , "", row) + "|";
            cellsStr
        }, grid);

        // Add horizontal lines between rows
        let hLine = horizontalLine(width);
        let rows = List.intersperse(hLine, rowStrings);
        
        // Add top and bottom borders
        String.unlines(hLine :: rows ::: hLine :: Nil)
} 