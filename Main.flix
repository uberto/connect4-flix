def main(): Unit \ IO = 
    // Create an empty grid
    let grid = Grid.mkEmptyGrid(7, 5);
    
    // Display the grid
    println(Grid.gridToString(grid)) 