package src.java;

public class EncodeFromUnicodeDriver {
	public static void main(String[] args) {
		int counter = 0;
		for (String element : args)
			counter++;
		if (counter != 1)
			System.out.println("ERROR_incorrect_num_params");
		else {
			HexEncoder test = new HexEncoder();
			System.out.println(test.EncodeFromUnicode(args[0]));
		}
	}
}
