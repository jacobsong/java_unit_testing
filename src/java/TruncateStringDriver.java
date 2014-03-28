package src.java;

public class TruncateStringDriver
{
	public static void main(String[] args)
	{
		int counter = 0;
		for (String element : args)
			counter++;
		if (counter != 2)
			System.out.println("ERROR_incorrect_num_params");
		else {
			String arg1 = args[0];
			int arg2 = Integer.parseInt(args[1]);
			StringUtils SU = new StringUtils();
			String output = SU.TruncateString(arg1, arg2);
			System.out.println(output);
		}
	}
}
