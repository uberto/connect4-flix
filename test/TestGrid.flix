mod TestGrid {
    use Cell.{Empty, Red, Yellow}

    @test
    def testEmptyGrid(): Bool = 
        let grid = Grid.mkEmptyGrid(7, 5);
        let expected = String.unlines(
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" :: Nil
        );
        Grid.gridToString(grid) == expected

    @test
    def testSingleRedDisc(): Bool \ IO = 
        let emptyRows = Grid.mkEmptyGrid(7, 3);
        let redRow = Grid.mkCellList(Empty, 3) ::: Red :: Grid.mkCellList(Empty, 3);
        let grid = emptyRows ::: redRow :: Nil;
        let expected = String.unlines(
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   | R |   |   |   |" ::
            "+---+---+---+---+---+---+---+" :: Nil
        );
        let actual = Grid.gridToString(grid);
        println("Expected:");
        println(expected);
        println("Actual:");
        println(actual);
        actual == expected

    @test
    def testSingleYellowDisc(): Bool = 
        let emptyRows = Grid.mkEmptyGrid(7, 3);
        let yellowRow = Grid.mkCellList(Empty, 3) ::: Yellow :: Grid.mkCellList(Empty, 3);
        let grid = emptyRows ::: yellowRow :: Nil;
        let expected = String.unlines(
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   | Y |   |   |   |" ::
            "+---+---+---+---+---+---+---+" :: Nil
        );
        Grid.gridToString(grid) == expected

    @test
    def testPlaceDisc(): Bool \ IO = 
        // Create an empty grid
        let grid = Grid.mkEmptyGrid(7, 4);
        
        // Place a red disc in column 3 (0-based)
        let gridWithRed = Grid.placeDisc(grid, 3, Red);
        let afterRed = Grid.gridToString(gridWithRed);
        println("After placing Red:");
        println(afterRed);
        
        // Place a yellow disc in column 2
        let gridWithBoth = Grid.placeDisc(gridWithRed, 2, Yellow);
        let afterYellow = Grid.gridToString(gridWithBoth);
        println("After placing Yellow:");
        println(afterYellow);
        
        let expected = String.unlines(
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   |   |   |   |   |   |" ::
            "+---+---+---+---+---+---+---+" ::
            "|   |   | Y | R |   |   |   |" ::
            "+---+---+---+---+---+---+---+" :: Nil
        );
        println("Expected:");
        println(expected);
        afterYellow == expected
} 