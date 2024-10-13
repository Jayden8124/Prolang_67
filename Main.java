import java.io.FileReader;
import java.io.IOException;

public class Main {
    public static void main(String[] args) {
        try {
            FileReader reader = new FileReader("input.txt");
            Lexer lexer = new Lexer(reader);
            lexer.yylex();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}