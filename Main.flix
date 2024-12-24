def repeat(s: String, n: Int32): String =
    if (n <= 0) ""
    else if (n == 1) s
    else s + repeat(s, n - 1)

def main(): Unit \ IO = 
    // Grid dimensions
    let rows = 5;
    let cols = 7;
    
    // Print top border
    println(repeat("+---", cols) + "+");
    
    // Print rows
    List.range(0, rows) |> List.forEach(_ -> {
        // Print cell content
        println(repeat("|   ", cols) + "|");
        // Print horizontal line after each row
        println(repeat("+---", cols) + "+")
    }) 